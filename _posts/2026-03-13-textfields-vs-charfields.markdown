---
title: Admitting my hubris (and unconstrained TextFields and CharFields)
date: 2026-03-13 16:20:00 +0000
---

This post went in a different direction than I thought it would. I was going to write that given a CharField is *always* limited by its maximum length, so why not *always* use the TextField, which has unlimited length?

Then I actually read [the documentation for CharField](https://docs.djangoproject.com/en/stable/ref/models/fields/#charfield). It’s not explicitly called out, but the `max_length` argument is optional and has a default value of `None`.

> ```python
> class CharField(max_length=None, **options)
> ```

I was shocked that you don’t have to specify a maximum length at all! I’d assumed that this was a required argument for more than a decade. This assumption is a hold-over from working with SQL Server circa 2000. I did a quick test, and was amazed to see that it’s true.

The documentation calls out that it is required for some database backends in some scenarios (in MySQL, the maximum length must be less than or equal to 255 if there’s a uniqueness constraint on the field, for example). But in a surprising number of instances it’s optional.

Now this doesn’t mean that CharFields are unlimited. But neither are TextFields. I’ve done some digging and found the following limits in the databases supported by Django:

| Database | CharField maximum length | TextField maximum length |
|--|--|--|
| PostgreSQL 18 | about 1 GB[^postgres-18] | about 1 GB[^postgres-18] |
| MySQL 9 | 65,535 characters[^mysql-9-varchar] | 4 GiB[^mysql-9-longtext] |
| Oracle 19 | 4 KB[^oracle-19] | 4 GB[^oracle-19] |
| SQLite | 1 GB[^sqlite] | 1 GB[^sqlite] |

[^postgres-18]: https://www.postgresql.org/docs/current/datatype-character.html
[^mysql-9-varchar]: https://dev.mysql.com/doc/refman/9.5/en/char.html
[^mysql-9-longtext]: https://dev.mysql.com/doc/refman/9.5/en/string-type-syntax.html
[^oracle-19]: https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/datatype-limits.html
[^sqlite]: https://sqlite.org/limits.html

Where does this leave us? For my work which is mostly in PostgreSQL, it doesn’t matter whether you use a CharField or a TextField—they can store the same amount of data. The same is true for SQLite.

But there is a difference in MySQL, and a significant difference in Oracle.

If there are no other concerns, preferring TextFields over CharFields still seems a good idea. They consistently store a string which is much, much larger than anything you’d reasonably want to put into a database. But it doesn't matter quite as much as I'd previously thought.

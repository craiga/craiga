---
title: Django and the curious case of the disappearing materialized view
date: 2026-05-14 19:45:00 +0100
---

A project I've been working on depends on a number of [materialized views](https://www.postgresql.org/docs/current/rules-materializedviews.html), a nifty feature of Postgres which is somewhere between a traditional view and a table.

If you've got some complex query that takes a long time to run, materialized views can be very useful. A materialized view will run that complex query, store the result, and then return that stored result to anyone who queries that view.

Here's an example materialized view, adapted from [Postgres' documentation](https://www.postgresql.org/docs/current/rules-materializedviews.html) to demonstrate how this might work when querying tables created by Django:


```sql
CREATE MATERIALIZED VIEW sales_summary AS
SELECT
    seller_no,
    invoice_date,
    sum(invoice_amt)::numeric(13,2) as sales_amt
  FROM invoices_invoice
  WHERE invoice_date < CURRENT_DATE
  GROUP BY
    seller_no,
    invoice_date;
```

…and here's what that Django model might look like:

```python
class Invoice(models.Model):
    seller_no = models.IntegerField()
    invoice_date = models.DateField()
    invoice_amt = models.DecimalField(
        max_digits=13, decimal_places=2
    )
```

If you try to drop a column used by a materialized view in Postgres, you'll get an error:

```
mydb=> ALTER TABLE invoices_invoice DROP COLUMN invoice_date;
ERROR:  cannot drop column invoice_date of table invoice because other objects depend on it
DETAIL:  materialized view sales_summary depends on column invoice_date of table invoices_invoice
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
```

However, if you drop that column via a Django migration, you get no such error. This is because Django will drop the column using that `CASCADE` keyword. That will cause the materialized view to be deleted silently.

```
./manage.py sqlmigrate invoices 0002_remove_invoice_date

BEGIN;
--
-- Remove field invoice_date from invoice
--
ALTER TABLE "invoices_invoice" DROP COLUMN "invoice_date" CASCADE;
COMMIT;
```

I haven’t been able to find a way to work around this. If you happen to know one, please reach out and I’ll update this post.
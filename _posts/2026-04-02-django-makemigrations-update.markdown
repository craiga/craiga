---
title: Updating Django migrations in place
date: 2026-04-02 14:15:00 +0100
---

Today I learned about [the `--update` option](https://docs.djangoproject.com/en/stable/ref/django-admin/#cmdoption-makemigrations-update) in Django's `makemigrations` command.

From [Django's documentation](https://docs.djangoproject.com/en/stable/ref/django-admin/#cmdoption-makemigrations-update):

> Merges model changes into the latest migration and optimize the resulting operations.
>
> The updated migration will have a generated name. In order to preserve the previous name, set it using `--name`.

I've got no idea how long this option has existed, but I've already found it helpful in reducing the amount of migration wrangling I've needed to do manually.

## Using the --name option

The `--name` option is a bit fiddly; it’ll take whatever name you provide and prefix it with a migration number, but will also suffix the name with “_update”.

For example, `--name my_migration` will create a migration file named `0002_my_migration_update.py`.

## It handles RunPython operations … sort of

If the migration you're updating contains any `RunPython` operations, it will preserve them, but it won't copy the code for you.

In the new updated migration, your `RunPython` operation will look like this:

```python
migrations.RunPython(
    code=my_app.migrations.0002_my_migration.do_thing,
),
```

…and the following comment is injected into the file:

```python
# Functions from the following migrations need manual copying.
# Move them and any dependencies into this file, then update the
# RunPython operations to refer to the local versions:
# my_app.migrations.0002_my_migration
```

I suspect this is the reason the new migration is created with the… `_updated` suffix; the existing migration needs to be left untouched so that the user can copy over functions.

I suspect other operations are handled similarly, but I haven't tested them.


## Can only update “leaf” migrations

Unfortunately, `--update` can’t apply changes to a migration that another migration relies on.

```
❯ ./manage.py makemigrations --update
CommandError: Cannot update migration 'new_thing.0001_initial' that migrations 'other_thing.0002_changes_on_top_of_new_thing' depend on.
```

This is fair enough—Django can’t know if updates to `new_thing.0001_initial` will have any flow-on effects to `other_thing.0002_changes_on_top_of_new_thing`.

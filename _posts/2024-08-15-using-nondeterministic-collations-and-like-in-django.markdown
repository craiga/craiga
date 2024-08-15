---
title: Using nondeterministic collations and LIKE in Django
date: 2024-08-15 16:00:00 +0100
---

In [Django and PostgreSQL, the recommended way to create case-insensitive text field is to use a case-insensitive collation](https://docs.djangoproject.com/en/stable/ref/contrib/postgres/fields/#citext-fields). This sounds tricky, though it's really quite simple.

First, [create a collation inside a migration](https://docs.djangoproject.com/en/stable/ref/contrib/postgres/operations/#managing-collations-using-migrations):

```python
"""Create a case-insensitive collation."""

from django.contrib.postgres.operations import CreateCollation
from django.db import migrations


class Migration(migrations.Migration):
    """Create a case-insensitive collation."""

    operations = (
        CreateCollation(
            "case_insensitive",
            provider="icu",
            locale="und-u-ks-level2",
            deterministic=False,
        ),
    )
```

Then you're free to use that collation whenever you create a text field on a model:

```python
class Dog(models.Model):
    name = models.TextField(
        db_collation="case_insensitive",
        help_text="Who's a good boy?",
    )
```

See, easy!

However, this collation will cause problems if you ever want to use `__contains` to filter a queryset:

```python
>>> Dog.objects.filter(name__contains="Craig")

NotSupportedError: nondeterministic collations are not supported for LIKE
```

You can work around this by annotating your queryset with a deterministic, case-sensitive version of the field, and swapping `__contains` for `__icontains`:

```python
>>> from django.db.models.functions import Collate
>>> Dog.objects.annotate(
        deterministic_name=Collate("name", "C")
    ).filter(
        deterministic_name__icontains="Craig"
    )

<QuerySet []>
```

Note that I'm using a collation named "C" here. I must admit that I'm no expert in collations, but "C" seems to be widely considered a default collation.

Also note that the queryset is empty, because Craig would be a weird name for a dog.

---
title: How to stop out-of-office replies to emails sent from Django
date: 2020-04-08 13:00:00 +0100
---

A little while back, I learned about the X-Auto-Response-Suppress header which requests that automated responses don't get sent to your emails. It works really well for us!

To apply this to a Django email backend, just add this simple mixin as shown below:

```python
from django.core.mail.backends import base, smtp

class OutOfOfficeSuppressMixin(base.BaseEmailBackend):
    """Mixin to add out of office suppression header to all emails."""

    def send_messages(self, email_messages: Sequence[EmailMessage]) -> int:
        for message in email_messages:
            if not "X-Auto-Response-Suppress" in message.extra_headers:
                message.extra_headers["X-Auto-Response-Suppress"] = "OOF"

        return super().send_messages(email_messages)


class SMTPEmailBackend(OutOfOfficeSuppressMixin, smtp.EmailBackend):
    pass
```

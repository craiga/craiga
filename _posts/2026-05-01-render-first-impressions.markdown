---
title: First impressions of Render
date: 2026-05-01 19:50:00 +0100
---

I've deployed quite a few apps to [Heroku](https://www.heroku.com) over the years and have loved it.

But there have been [some strange happenings](https://www.heroku.com/blog/an-update-on-heroku/) in the Heroku team over the past little while, which has me a bit concerned about the future of the product. As such, I've been thinking about alternatives to Heroku for the last little while.

Today I had a bit of a play around with [Render](https://render.com), one of the more popular Heroku alternatives. These are my first impressions.

## Cleaner infrastructure as code

In Heroku, configuration ends up being spread between `app.json`, `Procfile`, and some configuration that you can only do via the website or CLI. It’s a little messy, and a touch confusing.

In Render, everything seems to go into `render.yaml`.

## More complexity, more flexibility

It seems like Render exposes a little more functionality than you can get access to in Heroku. For example, you can restrict access to the database to certain IP addresses.

There’s a bit less stuff which happens by magic. When you deploy a Django app to Heroku, you never have to tell it to run `collecstatic`—this happens by magic. In Render, you need to script this yourself at the correct time.

It’s nice to have this extra functionality and flexibility, but it’s also an opportunity to mess stuff up.

## More expensive?

In order to use a lot of the functions of Render, you need to sign up for [a monthly plan](https://render.com/pricing), which starts at $25/month, plus the compute and storage you use.

You can use it at the free “hobby” tier and not pay that monthly fee, but that restricts what you can do. Infrastructure as code isn’t available in the hobby tier.

I haven’t done a side-by-side comparison of the costs of the different classes of Heroku dyno vs. Render instances, or done any comparative performance testing, but they feel roughly equivalent.

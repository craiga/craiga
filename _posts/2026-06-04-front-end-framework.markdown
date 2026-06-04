---
title: Am I wrong? Should I be using a front-end framework?
description: An old man questions himself before yelling at a cloud.
date: 2026-06-04 13:50:00 +0100
---

I learned web development in the late '90s and early 2000s. Back then, CSS was an emerging standard, and JavaScript was a nifty toy one could use to add annoying effects to your pages.

But you needed to write code on the server side to do anything interesting. My original tools of choice were ASP combined with SQL Server. A user of one of my apps would get a page from a server, which would run a select query and return the results to the user. That user could then post to a page, which would then run an update query and return the result of that operation.

It was just sending plain old HTML to the user.

Two-and-a-half decades later, things have changed a lot. JavaScript and its descendants have evolved into incredibly popular languages. Many applications have a front end using frameworks like React, Angular, or Vue, which are entire complex applications themselves running entirely in the browser, sending requests off to APIs to change shared state.

But my methods have stayed more or less the same. I moved on to using PHP and MySQL and then Django and PostgreSQL; but I still write apps where users get a web page which runs a select query, then post to a web page which runs an update query. I’ve used a little jQuery or HTMX, but I’m mostly just sending plain old HTML to the user.

---

A project I’m working on at the moment is making use of [Lucide icons](https://lucide.dev). I’d like to get these icons as SVG files so I can use them in my simple Django app.

They make a number of libraries installable via npm available on their site, most of which are targeted to JavaScript front-end frameworks. But there is one for my use case — the “static” version, so I click on that.

I’ve ended up on [the `lucide-static` Getting Started page](https://lucide.dev/guide/static/getting-started), which contains caveats and warnings about how using this library is a bad idea:

> `lucide-static` is suitable for *very specific use cases* where you want to use Lucide icons without relying on a JavaScript framework or component system.

> **Not recommended for production high performance needs**
> 
> SVG sprites and icon fonts include all icons, which can significantly increase your app's bundle size and load time.
>
> For production environments, we recommend using a bundler with tree-shaking support to include only the icons you actually use. Consider using one of the framework-specific packages.

From my perspective, this is silly. For one, I’m not going to use SCG sprites or an icon font; I just want to link to an individual SVG file. Secondly, this seems to be arguing that using a framework would be more performant than using no framework at all.

---

It feels like whenever I want to do anything in the front-end space—install a CSS framework, install an icon set, use an enhanced UI widget—I wrestle with the expectation that I’m trying to install the thing into a React, Angular, or Vue app. Most of the time I find a workaround or a hack to get the thing into the state I want it, but I’m starting to reflect on the idea that this struggle is a red flag. Maybe I should be using a front-end framework, even for the simple apps I’m building?

---

I understand the need for a front-end framework for a complex application like a social media site.

You need a component for direct messages which will update in real time when you receive a message. You need a component for notifications which will update when someone likes your latest selfie.

But I’ve never understood the appeal for sites which don’t have that complexity. Why add all those extra potential points of failure when you could do the same thing more efficiently with plain old HTML, CSS, and a touch of JavaScript?

---

We’ve had the basic building blocks of a simple web app for a long time. HTML has been able to send forms since 1995. CSS has been with us since 1996.

That also happens to be just before I started learning about this stuff.

React first launched in 2013. Vue was first released in 2014. Angular launched in 2016.

Around this period, HTML 5 was just starting its life as a living standard and adding a bunch of new elements and redefining old ones. CSS was far more complex than its initial draft and had an overwhelming number of vendor-specific capabilities. And I’ve never been able to understand what was going on with JavaScript at this time—ECMAScript, CommonJS, TypeScript were around at this time, each subtly different from each other.

When one considers how much more complex web development had gotten by the mid-2010s, it starts to make sense that front-end frameworks were simpler entry points for learners. Instead of learning HTML *and* CSS *and* JavaScript (*and* a server-side framework *and* how to set up nginx and so on), why not just learn one front-end framework that abstracts all of that stuff away?

---

I don’t think I’m wrong to eschew front-end frameworks for the kind of work I do. And I don’t think it’s a red flag that most front-end assets I want to use are tied up in formats that are only useful to front-end frameworks.

I think this is indicative of a failure of the simple building blocks of the web—HTML, CSS, and JavaScript—to remain accessible to users who are starting out. And the role I should be playing to educate younger developers about the advantages of these simpler technologies (even though they might not be quite so simple anymore).

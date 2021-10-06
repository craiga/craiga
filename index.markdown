---
title: Here are some things I built
id: home
layout: index
disable-sidebar-indexes: true
include-mobile-intro: true
---

<article class="thing-i-built preview">
  <figure><a href="https://mydatachameleon.com" data-fathom-goal-id="MTSWKGSU"><img src="/assets/screenshots/my-data-chameleon.jpg"></a></figure>
  <div>
    <h1><a href="https://mydatachameleon.com" data-fathom-goal-id="MTSWKGSU">My Data Chameleon</a></h1>
    <p>Helps users prepare their energy efficiency program data for submission to the
      California Public Utilities Commission.
      Built for <a href="https://www.sharperinfo.com">Sharper Informatics Solutions</a>.</p>
  </div>
</article>
<article class="thing-i-built preview">
  <figure><a href="http://unixtimesta.mp" data-fathom-goal-id="RIVS7KEW"><img src="/assets/screenshots/unixtimestamp.jpg"></a></figure>
  <div>
    <h1><a href="http://unixtimesta.mp" data-fathom-goal-id="RIVS7KEW">unixtimesta.mp</a></h1>
    <p>Since <a href="https://www.unixtimesta.mp/1300013503" data-fathom-goal-id="RIVS7KEW">2011</a> I've been running this site which converts Unix Time to and from human-readable time.</p>
  </div>
</article>
<article class="thing-i-built preview">
  <figure><a href="http://gagh.biz/game" data-fathom-goal-id="CDWN0BWW"><img src="/assets/screenshots/will-of-the-prophets.jpg"></a></figure>
  <div>
    <h1><a href="http://gagh.biz/game" data-fathom-goal-id="CDWN0BWW">Game of Buttholes: Will of the Prophets</a></h1>
    <p>A site I'm a little bit embarassed to have built for <a href="http://gagh.biz/">my favourite podcast</a>.</p>
  </div>
</article>

<header>
  <h1>Here are some things I wrote</h1>
</header>

{% for post in site.posts %}

<article class="preview">
  {% if post.image %}
    <figure><img src="{{ post.image }}" alt="{{ post.image_description }}"></figure>
  {% endif %}
  <div>
    <h1><a href="{{ post.url }}">{{ post.title }}</a></h1>
    <p class="small">Published {{ post.date | date: "%e %B, %Y" }}.</p>
    {% if post.description %}
        <p>{{ post.description }}</p>
    {% endif %}
  </div>
</article>
{% endfor %}

---
layout: post
title: Howto run this site on Linux Mint
excerpt: "Running this site on Linux Mint for easy writing can be a pain in the ass. This blog will help with this"
modified: 2016-06-15
tags: [intro, beginner, jekyll, tutorial, github pages]
comments: true
image:
  feature: sample-image-5.jpg
  credit: WeGraphics
  creditlink: http://wegraphics.net/downloads/free-ultimate-blurred-background-pack/
---

<section id="table-of-contents" class="toc">
  <header>
    <h3>Overview</h3>
  </header>
<div id="drawer" markdown="1">
*  Auto generated table of contents
{:toc}
</div>
</section><!-- /#table-of-contents -->

# Basic command

{% highlight shell %}
bundle exec jekyll serve
{% endhighlight %}

# Prerequisite
* Ruby >= 2.0 ([Tutorial](http://tecadmin.net/install-ruby-on-rails-on-ubuntu/#))
* gem install bundler 
* Gemfile
* gem install 

## Gemfile
{% highlight ruby %}
source 'https://rubygems.org'
gem 'github-pages', group: :jekyll_plugins
{% endhighlight %}

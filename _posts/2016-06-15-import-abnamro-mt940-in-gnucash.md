---
layout: post
title: Howto import MT940 files from ABNAMRO into GnuCash
excerpt: "GnuCash has the option to import MT940 files created by a bank. These files contain all transaction information. Currenlty the MT940 file created by ABNAMRO cannot be read by default"
modified: 2016-06-15
tags: [intro, beginner, tutorial, GnuCash, ABNAMRO, MT940]
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

# Problem 
[GnuCash](http://www.gnucash.org) is personal and small-business financial-accounting software, freely licensed under the GNU GPL and available for GNU/Linux, BSD, Solaris, Mac OS X and Microsoft Windows.

Designed to be easy to use, yet powerful and flexible, GnuCash allows you to track bank accounts, stocks, income and expenses. As quick and intuitive to use as a checkbook register, it is based on professional accounting principles to ensure balanced books and accurate reports. 

One of the key futures which I use the most is importing bank statements. These can often be downloaded in a MT940 format. This format ensures that the receiving application understands the transaction details. However: One Dutch bank in particular (ABN-AMRO) creates a slightly different version of the MT940 file. This file cannot be interpreted by GnuCash by default. A small tweak is required to make this import possible.
 
# Tweak
To make this tweak work the file _swiftmt940.conf_ needs to be updated. This file can be found in the following location:

* Windows: C:\Program Files\gnucash\share\aqbanking\imexporters\swift\profiles
* Linux: /usr/share/aqbanking/imexporters/swift/profiles/

Open the file and change the line:
{% highlight c %}
int skipDocLines="0"
{% endhighlight %}
into 
{% highlight c %}
int skipDocLines="3"
{% endhighlight %}
end your done. The import of the file should work now.

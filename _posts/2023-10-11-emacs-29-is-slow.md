
# Table of Contents

1.  [Situation](#orgcd3c9d6)
2.  [Symptoms](#org18a2170)
3.  [Solution](#orgb3ea06a)



<a id="orgcd3c9d6"></a>

# Situation

Last week I updated my Emacs installation on my macOS to the latest version 29.1. This resulted in a couple of issues I had to solve:  

1.  My org-mode update was incompatible with version 29.1
2.  My Emacs became laggy

To start with teh first issue, I quickly became aware that org-mode shipped with the `Emacsformac` version was having issues. So I downgraded to a previous org-mode which solved the issue.  

Issue number 2 was a more difficult issue.  


<a id="org18a2170"></a>

# Symptoms

When I upgraded to Emacs 29.1 using `brew` I noticed that my Emacs became slow. And slow in this case means that it was lagging. Not always, not every time, but enough to annoy me. When I wanted to mark a task `DONE` for example, this would take a lot of time. And then I really am talking about *seconds* (yes, multiple)!  

This is off course really annoying, so I started the famous Google search. At first, the symptoms where vague and difficult to find. But after searching a while, [Reddit](https://www.reddit.com/r/emacs/comments/15o1vke/emacs_29_slowness/) gave me an hint on where to look. More people where having the issue.  


<a id="orgb3ea06a"></a>

# Solution

After reading thru the comments on [Reddit](https://www.reddit.com/r/emacs/comments/15o1vke/emacs_29_slowness/) I was triggered by the comment to install a different version of Emacs.  

So I started by uninstalling the version I had (<https://emacsforosx.com/>):  

```shell
brew uninstall emacs

```

After that I installed [Emacs-Plus](https://github.com/d12frosted/homebrew-emacs-plus) (29.1) using `homebrew`:  

```shell
brew tap d12frosted/emacs-plus
brew install emacs-plus --with-ctags --with-dbus --with-mailutils --with-imagemagick

```

Using the extra options to make it workable for me.  

Behold, this solved my issue!  


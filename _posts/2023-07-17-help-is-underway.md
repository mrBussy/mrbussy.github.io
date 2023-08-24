
# Table of Contents

1.  [Help(ful)!](#org2ff7da5)



<a id="org2ff7da5"></a>

# Help(ful)!

Today I stumbled on a small package called [helpful](https://github.com/Wilfred/helpful). This package will extend the `emacs` help system. It provides a better way of displaying the help and is installed really quick. Just add the following lines:

```emacs-lisp
(use-package helpful
  :bind
  ([remap describe-function] . helpful-callable)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-command]  . helpful-command)
  ([remap describe-key]      . helpful-key))

```

Where I:

-   use `use-package` to install a package
-   map the helpful command to the different `describe` functions

And that is it for today. Small but simple update on the `emacs` help system.


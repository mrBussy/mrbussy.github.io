
# Table of Contents

1.  [Why use org mode](#org3f3bbbd)

\#+title Jekyll and OrgMode


<a id="org3f3bbbd"></a>

# Why use org mode

I really love the options `org` provides. Therefore I want to be able to use org-mode to create my posts.

I found a concept [here](https://thackl.github.io/blogging-with-emacs-org-mode-and-jekyll) that provided my the insights how to create one. However, I made some changes to support my own setup. For example: I would love to set the export option with the project so I created a custom `.dir-locals.el` and a custom function `rm/export-mrbussy-md-posts`.

```emacs-lisp
((nil . ((org-publish-project-alist . 
                                    (("mrbussy.github.io" ;; my blog project (just a name)
                                      ;; Path to org files.
                                      :base-directory "~/dev/mrbussy.github.io/_org/"
                                      :base-extension "org"
                                      ;; Path to Jekyll Posts
                                      :publishing-directory "~/dev/mrbussy.github.io/_posts/"
                                      :recursive t
                                      :publishing-function  rm/export-mrbussy-md-posts
                                      ;;:headline-levels 4
                                      ;;:body-only t
                                      ))))))

```

```emacs-lisp
;; Wrapper function around the ~org-md-export-as-markdown~ function
(defun rm/export-mrbussy-md-posts (plist filename pub-dir)
  (interactive)

   (if (string-suffix-p ".org" filename)
       (with-current-buffer (find-file-noselect filename)
         (with-current-buffer (org-md-export-as-markdown)
           (write-file (concat pub-dir (string-trim (f-filename filename) nil ".org") ".md") nil)))))


```


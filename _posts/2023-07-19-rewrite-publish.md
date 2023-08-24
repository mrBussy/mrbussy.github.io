
# Table of Contents

1.  [Why](#org9bbb45d)
2.  [Solution](#org40ad36d)
    1.  [The translator](#org00675eb)
    2.  [The export backend](#org6d4eb81)
    3.  [Create the publish project](#org4eed853)
    4.  [Save the configuration](#org0d798d7)



<a id="org9bbb45d"></a>

# Why

While exporting the posting earlier today, I found out that exporting the code-blocks did not go as expected. Let me explain:  
I write posts in `org-mode`. For me that is a well known format that I like to use. I use the `org-publish` functionality to publish my org-mode files to markdown format. It is during this conversion that the code-blocks are not transformed in correct markdown format.  

I used a special function as a wrapper around `org-md-export-as-markdown` function. This is to get the files in the right directory. Nothing more. It used the earlier mentioned function to convert the content to markdown.  


<a id="org40ad36d"></a>

# Solution

The solution I went for was a bit of a search.  

1.  First I looked for any other solution out there. Of course I could not find any.
2.  Next I used a custom `filter` to convert the `src-block` to a formated form. This did also not work since I could not identify the language being used.
3.  I wrote a custom backend to convert. This was the right solution.


<a id="org00675eb"></a>

## The translator

Let's first translate the src-block using a custom function.  

```emacs-lisp
(defun rm/translate-src-block-to-md-src-block (src-block contents info)
         "Transcode a SRC-BLOCK element from Org to markdown.
CONTENTS is nil.  INFO is a plist used as a communication
channel."

         (concat "```"
                 (org-element-property :language src-block)
                 "\n"
                 (org-export-format-code-default src-block info) "\n```"))


```

What this function does is quit simple: Take the source block and add a formatter around it. That's it.  


<a id="org6d4eb81"></a>

## The export backend

Next we had to write a backend that would invoke the translator. This was also not really hard to do.  

```emacs-lisp
(org-export-define-derived-backend 'jekyll-markdown 'md
  :translate-alist '((src-block . rm/translate-src-block-to-md-src-block)))

```

This function will expose a new backend that will translate the source blocks. After that it will use the default `md` backend to further perform magic.  


<a id="org4eed853"></a>

## Create the publish project

Last but not final, I had to create the publisher. I added a custom function to support the creation of markdown and then store that in the right directory.  

```emacs-lisp
(defun rm/publish-org-to-md (plist filename pub-dir)
    "Publish an org file to markdown.
  See `export' to the list of arguments."
    (rm/publish-org-to 'jekyll-markdown filename ".md" plist pub-dir))

(defun rm/publish-org-to (backend filename extension plist &optional pub-dir)
  "Publish an Org file to a specified back-end.

BACKEND is a symbol representing the back-end used for
transcoding.  FILENAME is the filename of the Org file to be
published.  EXTENSION is the extension used for the output
string, with the leading dot.  PLIST is the property list for the
given project.

Optional argument PUB-DIR, when non-nil is the publishing
directory.

Return output file name."
  (unless (or (not pub-dir) (file-exists-p pub-dir)) (make-directory pub-dir t))
  ;; Check if a buffer visiting FILENAME is already open.
  (let* ((org-inhibit-startup t)
         (visiting (find-buffer-visiting filename))
         (work-buffer (or visiting (find-file-noselect filename))))
    (unwind-protect
        (with-current-buffer work-buffer
          (let ((output (org-export-output-file-name extension nil pub-dir)))
            (org-export-to-file backend output
              nil nil nil (plist-get plist :body-only)
              ;; Add `org-publish--store-crossrefs' and
              ;; `org-publish-collect-index' to final output filters.
              ;; The latter isn't dependent on `:makeindex', since we
              ;; want to keep it up-to-date in cache anyway.
              (org-combine-plists
               plist
               `(:crossrefs
                 ,(org-publish-cache-get-file-property
                   (expand-file-name filename) :crossrefs nil t)
                 :filter-final-output
                 (org-publish--store-crossrefs
                  org-publish-collect-index
                  ,@(plist-get plist :filter-final-output)))))))
      ;; Remove opened buffer in the process.
      (unless visiting (kill-buffer work-buffer)))))


```

And finally I added the project to the list  

```emacs-lisp

(setq org-publish-project-alist '(("mrbussy.github.io (new)" ;; my blog project (just a name)
                                   ;; Path to org files.
                                   :base-directory "~/dev/mrbussy.github.io/_org/"
                                   :base-extension "org"
                                   ;; Path to Jekyll Posts
                                   :publishing-directory "~/dev/mrbussy.github.io/_posts/"
                                   :recursive t
                                   ;;:publishing-function rm/export-jekyll-org-posts
                                   :publishing-function rm/publish-org-to-md
                                   ;;:headline-levels 4
                                   ;;:body-only t
                                   )))


```

And with this my function is ready.  


<a id="org0d798d7"></a>

## Save the configuration

I've stored the configuration with the `.dir-locals.el` file so it can be loaded later on.  


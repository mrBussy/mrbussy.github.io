((nil .
       
      ((eval . (setq org-publish-project-alist '(("mrbussy.github.io (new)" ;; my blog project (just a name)
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
                                     ))))
      
       ;; Add a custom backend to the list of conversions.
       ;; This jekyll to markdown backend will take any input and convert it to markdown
       ;; more specific, it will translate the source block and pass the rest toward the
       ;; origional markdown
       (eval .   (org-export-define-derived-backend 'jekyll-markdown 'md
		   :translate-alist '((src-block . rm/translate-src-block-to-md-src-block)))))
))


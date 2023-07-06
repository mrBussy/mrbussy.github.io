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

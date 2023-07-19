((nil .
      ((defun rm/translate-src-block-to-md-src-block (src-block contents info)
	 "Transcode a SRC-BLOCK element from Org to markdown.
CONTENTS is nil.  INFO is a plist used as a communication
channel."
	 
	 (concat "```"
		 (org-element-property :language src-block)
		 "\n"
		 (org-export-format-code-default src-block info) "\n```"))

       ;; Add a custom backend to the list of conversions.
       ;; This jekyll to markdown backend will take any input and convert it to markdown
       ;; more specific, it will translate the source block and pass the rest toward the
       ;; origional markdown
       (org-export-define-derived-backend 'jekyll-markdown 'md
	 :translate-alist '((src-block . rm/translate-src-block-to-md-src-block)))

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
	      (message "[rm]: %" filename extension backend)
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

       )))

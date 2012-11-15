;;; add-log.el --- change log maintenance commands for Emacs

;;;###autoload
(defun add-change-log-entry2 (&optional whoami file-name other-window new-entry)
  "Find change log file and add an entry for today.
Optional arg WHOAMI (interactive prefix) non-nil means prompt for user
name and site.

Second arg is FILE-NAME of change log.  If nil, uses `change-log-default-name'.
Third arg OTHER-WINDOW non-nil means visit in other window.
Fourth arg NEW-ENTRY non-nil means always create a new entry at the front;
never append to an existing entry.  Option `add-log-keep-changes-together'
otherwise affects whether a new entry is created.

Today's date is calculated according to `change-log-time-zone-rule' if
non-nil, otherwise in local time."
  (interactive (list current-prefix-arg
		     (prompt-for-change-log-name)))
  (or add-log-full-name
      (setq add-log-full-name (user-full-name)))
  (or add-log-mailing-address
      (setq add-log-mailing-address user-mail-address))
  (if whoami
      (progn
	(setq add-log-full-name (read-input "Full name: " add-log-full-name))
	 ;; Note that some sites have room and phone number fields in
	 ;; full name which look silly when inserted.  Rather than do
	 ;; anything about that here, let user give prefix argument so that
	 ;; s/he can edit the full name field in prompter if s/he wants.
	(setq add-log-mailing-address
	      (read-input "Mailing address: " add-log-mailing-address))))

  (let* ((defun (add-log-current-defun))
	 (version (and change-log-version-info-enabled
		       (change-log-version-number-search)))
	 (buf-file-name (if add-log-buffer-file-name-function
			    (funcall add-log-buffer-file-name-function)
			  buffer-file-name))
	 (buffer-file (if buf-file-name (expand-file-name buf-file-name)))
	 (file-name (expand-file-name
		     (or file-name (find-change-log file-name buffer-file))))
	 ;; Set ENTRY to the file name to use in the new entry.
	 (entry (add-log-file-name buffer-file file-name))
	 bound
	 point-min-dummy) ;!

    (if (or (and other-window (not (equal file-name buffer-file-name)))
	    (window-dedicated-p (selected-window)))
	(find-file-other-window file-name)
      (find-file file-name))
    (or (eq major-mode 'change-log-mode)
	(change-log-mode))
    (undo-boundary)
    (goto-char (point-min))
;;;!
  (when (search-forward "__MEMO__" nil t)
	(next-line 1)(beginning-of-line)
	(setq point-min-dummy (point)))
;;;!
    (let ((new-entry (concat (funcall add-log-time-format)
			     "  " add-log-full-name
			     "  <" add-log-mailing-address ">")))
      (if (looking-at (regexp-quote new-entry))
	  (forward-line 1)
	(insert new-entry "\n\n")))

    (setq bound
	  (progn
            (if (looking-at "\n*[^\n* \t]")
                (skip-chars-forward "\n")
	      (if add-log-keep-changes-together
		  (forward-page)	; page delimits entries for date
		(forward-paragraph)))	; paragraph delimits entries for file
	    (point)))
    (goto-char point-min-dummy) ;!
    ;; Now insert the new line for this entry.
    (cond ((re-search-forward "^\\s *\\*\\s *$" bound t)
	   ;; Put this file name into the existing empty entry.
	   (if entry
	       (insert entry)))
	  ((and (not new-entry)
		(let (case-fold-search)
		  (re-search-forward
		   (concat (regexp-quote (concat "* " entry))
			   ;; Don't accept `foo.bar' when
			   ;; looking for `foo':
			   "\\(\\s \\|[(),:]\\)")
		   bound t)))
	   ;; Add to the existing entry for the same file.
	   (re-search-forward "^\\s *$\\|^\\s \\*")
	   (goto-char (match-beginning 0))
	   ;; Delete excess empty lines; make just 2.
	   (while (and (not (eobp)) (looking-at "^\\s *$"))
	     (delete-region (point) (line-beginning-position 2)))
	   (insert-char ?\n 2) ;! 2
	   (forward-line -2) ;! -2
	   (indent-relative-maybe))
	  (t
	   ;; Make a new entry.
	   (forward-line 1)
	   (while (looking-at "\\sW")
	     (forward-line 1))
	   (while (and (not (eobp)) (looking-at "^\\s *$"))
	     (delete-region (point) (line-beginning-position 2)))
	   (insert-char ?\n 2) ;! 3
	   (forward-line -1) ;! -2
	   (indent-to left-margin)
	   (insert "* ")
	   (if entry (insert entry))))
    ;; Now insert the function name, if we have one.
    ;; Point is at the entry for this file,
    ;; either at the end of the line or at the first blank line.
    (if defun
	(progn
	  ;; Make it easy to get rid of the function name.
	  (undo-boundary)
	  (unless (save-excursion
		    (beginning-of-line 1)
		    (looking-at "\\s *$"))
	    (insert ?\ ))
	  ;; See if the prev function name has a message yet or not
	  ;; If not, merge the two entries.
	  (let ((pos (point-marker)))
	    (if (and (skip-syntax-backward " ")
		     (skip-chars-backward "):")
		     (looking-at "):")
		     (progn (delete-region (+ 1 (point)) (+ 2 (point))) t)
		     (> fill-column (+ (current-column) (length defun) 3)))
		(progn (delete-region (point) pos)
		       (insert ", "))
	      (goto-char pos)
	      (insert "("))
	    (set-marker pos nil))
	  (insert defun "): ")
	  (if version
	      (insert version ?\ )))
      ;; No function name, so put in a colon unless we have just a star.
      (unless (save-excursion
		(beginning-of-line 1)
		(looking-at "\\s *\\(\\*\\s *\\)?$"))
	(insert ": ")
	(if version (insert version ?\ ))))))

(provide 'add-change-log-entry2)

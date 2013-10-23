(defun yahtml-goto-corresponding-* (&optional other)
  "Go to corresponding object."
  (interactive)
  (cond
   ((yahtml-goto-corresponding-begend))
   (t (message "I don't know where to go."))
   ))

(defun yahtml-goto-corresponding-begend (&optional noerr)
  "Go to corresponding opening/closing tag.
Optional argument NOERR causes no error for unballanced tag."
  (let ((cmd (yahtml-on-begend-p)) m0
	(p (point)) (case-fold-search t) func str (nest 0))
    (cond
     (cmd
      (setq m0 (match-beginning 0))
      (if (= (aref cmd 0) ?/)		;on </cmd> line
	      (setq cmd (substring cmd 1)
		    str (format "\\(<%s\\)\\|\\(</%s\\)" cmd cmd)
		    func 're-search-backward)
	    (setq str (format "\\(</%s\\)\\|\\(<%s\\)" cmd cmd)
		  func 're-search-forward))
      (while (and (>= nest 0) (funcall func str nil t))
	(if (equal m0 (match-beginning 0))
	    nil
	  (setq nest (+ nest (if (match-beginning 1) -1 1)))))
      (if (< nest 0)
	  (goto-char (match-beginning 0))
	(funcall
	 (if noerr 'message 'error)
	 "Corresponding tag of `%s' not found." cmd)
	(goto-char p)
	nil))
     (t nil))))

(defun yahtml-on-begend-p (&optional p)
  "Check if point is on begend clause."
  (let ((p (or p (point))) cmd (case-fold-search t))
    (save-excursion
      (goto-char p)
      (if (equal (char-after (point)) ?<) (forward-char 1))
      (if (and (re-search-backward "<" nil t)
	       (looking-at
		;(concat "<\\(/?" yahtml-struct-name-regexp "\\)\\b")
		"<\\(/?[A-Z][A-Z0-9]*\\)\\b"
		)
	       (condition-case nil
		   (forward-list 1)
		 (error nil))
	       (< p (point)))
	  (YaTeX-match-string 1)))))

(defun YaTeX-match-string (n &optional m)
  "Return (buffer-substring (match-beginning n) (match-beginning m))."
  (if (match-beginning n)
      (buffer-substring (match-beginning n)
			(match-end (or m n)))))

(define-key html-mode-map "\C-cg" 'yahtml-goto-corresponding-*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; ---------- translate to entity references ----------
(defvar yahtml-entity-reference-chars-alist-default
  ;'((?> . "gt") (?< . "lt") (?& . "amp") (?\" . "quot") (?' . "apos"))
  '((?> . "gt") (?< . "lt") (?& . "amp") (?\" . "quot"))
  "Default translation table from character to entity reference")
(defvar yahtml-entity-reference-chars-alist nil
  "*Translation table from character to entity reference")
(defvar yahtml-entity-reference-chars-regexp nil)
(defvar yahtml-entity-reference-chars-reverse-regexp nil)

(defun yahtml-entity-reference-chars-setup ()
  (let ((list (append yahtml-entity-reference-chars-alist-default
		      yahtml-entity-reference-chars-alist)))
    (setq yahtml-entity-reference-chars-regexp "["
	  yahtml-entity-reference-chars-reverse-regexp "&\\(")
    (while list
      (setq yahtml-entity-reference-chars-regexp
	    (concat yahtml-entity-reference-chars-regexp
		    (char-to-string (car (car list))))
	    yahtml-entity-reference-chars-reverse-regexp
	    (concat yahtml-entity-reference-chars-reverse-regexp
		    (cdr (car list))
		    (if (cdr list) "\\|")))
      (setq list (cdr list)))
    (setq yahtml-entity-reference-chars-regexp
	  (concat yahtml-entity-reference-chars-regexp "]")
	  yahtml-entity-reference-chars-reverse-regexp
	  (concat yahtml-entity-reference-chars-reverse-regexp "\\);"))))

(yahtml-entity-reference-chars-setup)

(defun yahtml-translate-region (beg end)
  "Translate inhibited literals."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (let ((ct (append yahtml-entity-reference-chars-alist
		       yahtml-entity-reference-chars-alist-default)))
	(goto-char beg)
	(while (re-search-forward yahtml-entity-reference-chars-regexp nil t)
	  ;(setq c (preceding-char))
	  (replace-match
	   (concat "&" (cdr (assoc (preceding-char) ct)) ";")))))))

(define-key html-mode-map "\C-c;" 'yahtml-translate-region)

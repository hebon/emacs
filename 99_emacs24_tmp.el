
;; utf8
;;(prefer-coding-system 'utf-8)
;(modify-coding-system-alist 'file "\\.html\\'" 'utf-8)

(defun find-file-utf8 ()
  (interactive)
  (let ((coding-system-for-read 'utf-8-unix)
		(coding-system-for-write 'utf-8-unix))
;;	(call-interactively 'find-file)))
	(call-interactively 'find-alternate-file)))
(global-set-key "\C-xa8" 'find-file-utf8)

(defun find-file-utf8-dos ()
  (interactive)
  (let ((coding-system-for-read 'utf-8-dos)
		(coding-system-for-write 'utf-8-dos))
	(call-interactively 'find-alternate-file)))

(defun find-file-euc ()
  (interactive)
  (let ((coding-system-for-read 'euc-jp-unix)
		(coding-system-for-write 'euc-jp-unix))
	(call-interactively 'find-alternate-file)))
(global-set-key "\C-xae" 'find-file-euc)
(defun find-file-sjis ()
  (interactive)
  (let ((coding-system-for-read 'shift_jis-dos)
		(coding-system-for-write 'shift_jis-dos))
	(call-interactively 'find-alternate-file)))
(global-set-key "\C-xas" 'find-file-sjis)

;; SQL
(defun sqltidy()
  (interactive)
  (save-excursion
	(align-regexp (point-min) (point-max)
				  "\\(\\s-*\\)\\( text\\| int\\| smallint\\| tinyint\\| datetime\\| date\\| time\\| timestamp\\| varchar\\| char[ (]\\)" 1 1)
	(align-regexp (point-min) (point-max) "\\(\\s-*\\)\\( NOT NULL\\)" 1 1)
	(align-regexp (point-min) (point-max) "\\(\\s-*\\)\\(default \\(NULL\\|'\\|[0-9]\\)\\|auto_increment\\)" 1 1)
	(untabify (point-min) (point-max))
))


(defun sqltidy-region(beg end)
  (interactive "r")
  (save-excursion
	(align-regexp beg end
				  "\\(\\s-*\\)\\( text\\| int\\| smallint\\| tinyint\\| datetime\\| date\\| time\\| timestamp\\| varchar\\| char[ (]\\)" 1 1)
	(align-regexp beg end "\\(\\s-*\\)\\( NOT NULL\\)" 1 1)
	(align-regexp beg end "\\(\\s-*\\)\\(default \\(NULL\\|'\\|[0-9]\\)\\|auto_increment\\)" 1 1)
	(untabify beg end)
))

;; kbd-macro
(fset 'css-clean
   [?\C-x ?h ?\C-\M-\\ ?\C-x ?h ?\M-x ?a ?l ?i ?g ?n ?- ?r ?e tab return ?: return ?\C-x ?h ?\M-x ?u ?n ?t ?a ?b ?i ?f ?y return C-home ?\M-% ?\C-q ?\C-j ?  ?  ?  ?  return ?\C-q ?\C-j ?\C-q tab return ?! C-home])

;;(fset 'changecode-utf8
;;   [?\C-x return ?f ?u ?t ?f ?- ?8 ?- ?u ?n ?i ?x return ?\C-x ?\C-s])

(defun changecode-utf8()
  (interactive)
  (set-buffer-file-coding-system 'utf-8-unix)
  (save-buffer))



;; indent-rigidly C-u 4 C-x [TAB]
;; open-rectangle C-x r o

(fset 'tab-region
   [?\C-x ?r ?t ?\C-q tab return])
(global-set-key "\C-cq" 'tab-region)

(fset 'enlarge-window-5
  [?\C-5 ?\C-x ?^])
(global-set-key "\C-^" 'enlarge-window-5)


;; key-bindings
;;(global-set-key "\C-cg" 'goto-line)
;;(global-set-key "\C-\\" nil) ;; toggle-input-method いらん
(global-unset-key "\C-\\")


;; file-cache
(require 'filecache)
(file-cache-add-directory-list
 (list "~"
       "~/memo"
       "~/git/marutaportal/maruta.be/" "~/git/marutaportal/maruta.be/public_html/"
       "~/git/marutaportal/maruta.be/data/common/html/service_admin/"
       "~/git/marutaportal/maruta.be/lib/IBlog" "~/git/marutaportal/maruta.be/lib/IBlog/Data"
       "~/git/intfloat-tools/perl"
	   "~/emacs_settings/"
	   "~/git/easyform/WebApp/easyform/easyform/" "~/git/easyform/WebApp/easyform/web_admin/"
       ))
(file-cache-add-file-list
 (list "~/git/marutaportal_doc/doc/iblog.sql"))
(define-key minibuffer-local-completion-map
  "\C-c\C-i" 'file-cache-minibuffer-complete)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ChangeLog
(require 'add-change-log-entry2)
(defun memo-shogoin ()
  (interactive)
    (add-change-log-entry2
     nil
     (expand-file-name "~/project/shogoin/memo.txt")
     t))
(global-set-key "\C-cmk" 'memo-shogoin)

(defun memo-imessage ()
  (interactive)
    (add-change-log-entry2
     nil
     (expand-file-name "~/project/ChangeLog-imessage.txt")
     t))
(global-set-key "\C-cmi" 'memo-imessage)

(defun memo-mebal ()
  (interactive)
    (add-change-log-entry2 
     nil
     (expand-file-name "~/project/ChangeLog-mebal.txt")
     t))
(global-set-key "\C-cmm" 'memo-mebal)

(defun memo-maruta-site-admin ()
  (interactive)
    (add-change-log-entry2 
     nil
     (expand-file-name "~/project/maruta/note.txt")
     t))
(global-set-key "\C-cms" 'memo-maruta-site-admin)

(defun memo-eoblog ()
  (interactive)
    (add-change-log-entry2 
     nil
     (expand-file-name "~/project/eoblog/note.txt")
     t))
(global-set-key "\C-cme" 'memo-eoblog)

(defun memo-todo ()
  (interactive)
    (add-change-log-entry2 
     nil
     (expand-file-name "~/todo/Todo.txt")
     t))
(global-set-key "\C-cmt" 'memo-todo)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; INSERT

;; marker
(defun imakoko()
  (interactive)
  (insert "\n#! --- IMAKOKO ---\n"))

;; Data::Dumper
(defun dump()
  (interactive)
  (insert "use Data::Dumper;\n")
  (insert "print \"Content-Type: text/html\\n\\n<plaintext>\";\n")
  (insert "print Dumper();\n"))

;; html
(defun form()
  (interactive)
  (insert "<form method=\"POST\" action=\"<itk name=CONFIG:SCRIPT_NAME>\">
    <input type=\"hidden\" name=\"mode\" value=\"\">
    <input type=\"submit\" value=\"送信\">
</form>"))


;; template

(defvar my-template-text-file "~/.template")
(defvar my-template-buffer nil)
(defvar my-template-point nil)

(defun my-template-insert ()
  (interactive)
  (let (content)
    (when (setq
           content
           (get-text-property (point) :content))
      (save-excursion
        (set-buffer my-template-buffer)
        (save-excursion
          (goto-char my-template-point)
          (insert content)))
      (delete-window)
      )))

(defun my-template-select ()
  (interactive)
  (let ((buffer
         (get-buffer-create "*select template*"))
        templates begin template-map text)
    (setq my-template-buffer (current-buffer)
          my-template-point  (point))
    (unless (file-readable-p my-template-text-file)
      (error "Couldn't read template file: %s"))
    (with-temp-buffer
      (insert-file-contents my-template-text-file)
      (goto-char (point-min))
      (while (re-search-forward "^\\*\\(.*\\)$" nil t)
        (when begin
          (setq templates
                (cons
                 (cons
                  (car templates)
                  (buffer-substring
                   begin (1- (match-beginning 0))))
                 (cdr templates))))
        (setq templates (cons (match-string 1) templates))
        (setq begin (1+ (match-end 0))))
      (when begin
        (setq templates
              (cons
               (cons
                (car templates)
                (buffer-substring begin (point-max)))
               (cdr templates)))))
    (pop-to-buffer buffer)
    (setq buffer-read-only nil
          major-mode       'template-select-mode
          mode-name        "Select Template"
          template-map     (make-keymap))
    (suppress-keymap template-map)
    (define-key template-map " "    'my-template-insert)
    (define-key template-map "\C-m" 'my-template-insert)
    (define-key template-map "n"    'next-line)
    (define-key template-map "p"    'previous-line)
    (define-key template-map "q"    'delete-window)
    (use-local-map template-map)
    (buffer-disable-undo)
    (delete-region (point-min) (point-max))
    (dolist (tt templates)
      (setq text (concat (car tt) "\n"))
      (put-text-property
       0 (length text) :content (cdr tt) text)
      (insert text)
      (goto-char (point-min)))
    (delete-region (1- (point-max)) (point-max))
    (setq buffer-read-only t)
    (set-buffer-modified-p nil)))

(global-set-key "\C-c1" 'my-template-select)


;;; dired を使って、一気にファイルの coding system (漢字) を変換する
;; m でマークして T で一括変換
(require 'dired-aux)
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key (current-local-map) "T"
              'dired-do-convert-coding-system)))

(defvar dired-default-file-coding-system nil
  "*Default coding system for converting file (s).")

(defvar dired-file-coding-system 'no-conversion)

(defun dired-convert-coding-system ()
  (let ((file (dired-get-filename))
        (coding-system-for-write dired-file-coding-system)
        failure)
    (condition-case err
        (with-temp-buffer
          (insert-file file)
          (write-region (point-min) (point-max) file))
      (error (setq failure err)))
    (if (not failure)
        nil
      (dired-log "convert coding system error for %s:\n%s\n" file failure)
      (dired-make-relative file))))

(defun dired-do-convert-coding-system (coding-system &optional arg)
  "Convert file (s) in specified coding system."
  (interactive
   (list (let ((default (or dired-default-file-coding-system
                            buffer-file-coding-system)))
           (read-coding-system
            (format "Coding system for converting file (s) (default, %s): "
                    default)
            default))
         current-prefix-arg))
  (check-coding-system coding-system)
  (setq dired-file-coding-system coding-system)
  (dired-map-over-marks-check
   (function dired-convert-coding-system) arg 'convert-coding-system t))


;; (defun describe-face-at-point ()
;;   "Return face used at point."
;;   (interactive)
;;   (message "%s" (get-char-property (point) 'face)))

;; (if window-system (progn
;; (set-face-foreground 'font-lock-comment-face "MediumSeaGreen")
;; (set-face-foreground 'font-lock-string-face  "purple")
;; (set-face-foreground 'font-lock-keyword-face "blue")
;; (set-face-foreground 'font-lock-function-name-face "blue")
;; (set-face-bold-p 'font-lock-function-name-face t)
;; (set-face-foreground 'font-lock-variable-name-face "black")
;; (set-face-foreground 'font-lock-type-face "LightSeaGreen")
;; (set-face-foreground 'font-lock-builtin-face "purple")
;; (set-face-foreground 'font-lock-constant-face "black")
;; (set-face-foreground 'font-lock-warning-face "blue")
;; (set-face-bold-p 'font-lock-warning-face nil)
;; ))

;; (set-face-foreground '(名前) "(色名)")	文字色を変更する
;; (set-face-background '(名前) "(色名)")	文字の背景色を変更する
;; (set-face-background '(名前) nil)	文字の背景色を設定しない
;; (set-face-bold-p '(名前) t)	太字（ボールド体）にする
;; (set-face-bold-p '(名前) nil)	太字（ボールド体）にしない
;; (set-face-italic-p '(名前) t)	イタリック体にする
;; (set-face-italic-p '(名前) nil)	イタリック体にしない
;; (set-face-underline-p '(名前) t)	下線を表示する
;; (set-face-underline-p '(名前) nil)	下線を表示しない


;; ^M削除
(defun trim-cr ()
  (interactive)
  (save-excursion
	(let ((end))
	  (end-of-buffer)
	  (setq end (point))
	  (beginning-of-buffer)
	  (while (re-search-forward "
" end t)
		(replace-match "")))))

;; リージョン内置換
(defun trim-cr-region (start end)
  (interactive "r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char (point-min))
    (while (re-search-forward "$" nil t) (replace-match "" nil t))))

;; scratch
(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    ;; "*scratch*" を作成して buffer-list に放り込む
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))
(defun my-buffer-name-list ()
  (mapcar (function buffer-name) (buffer-list)))
(add-hook 'kill-buffer-query-functions
    ;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
          (function (lambda ()
                      (if (string= "*scratch*" (buffer-name))
                          (progn (my-make-scratch 0) nil)
                        t))))
(add-hook 'after-save-hook
;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
          (function (lambda ()
                      (unless (member "*scratch*" (my-buffer-name-list))
                        (my-make-scratch 1)))))
(setq initial-scratch-message "")

;; ;; mapae
;; ;; perl ./mapae.pl getRecentPost
;; (require 'mapae "~/bin/meadow/site-lisp/mapae-0-10-20051017/mapae.el")
;; (setq mapae-perl-command "/usr/bin/perl")
;; (setq mapae-command "~/bin/meadow/site-lisp/mapae-0-10-20051017/mapae.pl")
;; (global-set-key "\C-cwn" 'mapae-new-post)
;; (global-set-key "\C-cwr" 'mapae-get-recent-post)
;; (global-set-key "\C-cwg" 'mapae-get-post)
;; (global-set-key "\C-cwl" 'mapae-get-recent-titles)


;; ;; ミニバッファの履歴の重複削除＋ファイル履歴から読み込めないファイルを削除
;; (defun my-minibuffer-delete-duplicate ()
;;   (let* ((hist (symbol-value minibuffer-history-variable))
;;          (last (car hist)))
;;     (when (eq minibuffer-history-variable 'file-name-history)
;;       ;; $HOME や ".." や "." は正則化する
;;       (setq last (concat "~/" (file-relative-name 
;;                                (expand-file-name (car hist)) "~/"))))
;;     (when (> (length hist) 1)
;;       (set minibuffer-history-variable (cons last (delete last (cdr hist)))))
;;     (when (eq minibuffer-history-variable 'file-name-history)
;;       (unless (file-readable-p last)
;;         (set minibuffer-history-variable (cdr hist))))))
;; (add-hook 'minibuffer-setup-hook 'my-minibuffer-delete-duplicate)

;; itk
(defun insert_itk ()
	   (interactive)
	   (insert "<itk name=\"\" xhtml>"))
(global-set-key "\C-ci" 'insert_itk)
(defun insert_itk_if ()
	   (interactive)
	   (insert "<itk_if name=\"\" value=\"\"></itk_if>"))
(global-set-key "\C-cf" 'insert_itk_if)

;; anything

(setq anything-for-files-prefered-list
      '(
        anything-c-source-buffers+
        anything-c-source-recentf
        anything-c-source-files-in-current-dir+
        anything-c-source-file-cache
        anything-c-source-ffap-line
        anything-c-source-ffap-guesser
;        anything-c-source-bookmarks
;        anything-c-source-locate
        ))


  ;; default
  ;; '(anything-c-source-ffap-line
  ;;   anything-c-source-ffap-guesser
  ;;   anything-c-source-buffers+
  ;;   anything-c-source-recentf
  ;;   anything-c-source-bookmarks
  ;;   anything-c-source-file-cache
  ;;   anything-c-source-files-in-current-dir+
  ;;   anything-c-source-locate)


;; from cperl-mode
;; for abbrev
(defun cperl-electric-keyword ()
  "Insert a construction appropriate after a keyword.
Help message may be switched off by setting `cperl-message-electric-keyword'
to nil."
  (let ((beg (save-excursion (beginning-of-line) (point)))
	(dollar (and (eq last-command-event ?$)
		     (eq this-command 'self-insert-command)))
	(delete (and (memq last-command-event '(?\s ?\n ?\t ?\f))
		     (memq this-command '(self-insert-command newline))))
	my do)
    (and (save-excursion
	   (condition-case nil
	       (progn
		 (backward-sexp 1)
		 (setq do (looking-at "do\\>")))
	     (error nil))
	   (cperl-after-expr-p nil "{;:"))
	 (save-excursion
	   (not
	    (re-search-backward
	     "[#\"'`]\\|\\<q\\(\\|[wqxr]\\)\\>"
	     beg t)))
	 (save-excursion (or (not (re-search-backward "^=" nil t))
			     (or
			      (looking-at "=cut")
			      (and cperl-use-syntax-table-text-property
				   (not (eq (get-text-property (point)
							       'syntax-type)
					    'pod))))))
	 (save-excursion (forward-sexp -1)
			 (not (memq (following-char) (append "$@%&*" nil))))
	 (progn
	   (and (eq (preceding-char) ?y)
		(progn			; "foreachmy"
		  (forward-char -2)
		  (insert "") ;#!
		  (forward-char 2)
		  (setq my t dollar t
			delete
			(memq this-command '(self-insert-command newline)))))
	   (and dollar (insert " $"))
	   (cperl-indent-line)
	   ;;(insert " () {\n}")
 	   (cond
 	    (cperl-extra-newline-before-brace
 	     (insert (if do "\n" "()\n"))
 	     (insert "{")
 	     (cperl-indent-line)
 	     (insert "\n")
 	     (cperl-indent-line)
 	     (insert "\n}")
	     (and do (insert " while ();")))
 	    (t
 	     (insert (if do "{\n}while();" "(){\n}"))))
	   (or (looking-at "[ \t]\\|$") (insert " "))
	   (cperl-indent-line)
	   (if dollar (progn (search-backward "$")
			     (if my
				 (forward-char 1)
			       (delete-char 1)))
	     (search-backward ")")
	     (if (eq last-command-event ?\()
		 (progn			; Avoid "if (())"
		   (delete-backward-char 1)
		   (delete-backward-char -1))))
	   (if delete
	       (cperl-putback-char cperl-del-back-ch))
	   (if cperl-message-electric-keyword
	       (message "Precede char by C-q to avoid expansion"))))))

;; yasnippet
(when (require 'yasnippet nil t)

  ;; oneshot-snippet
  (require 'yasnippet-config)
;;  (yas/setup "~/.emacs.d/snippets")


  (yas/initialize)
  (setq yas/root-directory "~/.emacs.d/snippets")
  (yas/load-directory yas/root-directory)
  (require 'dropdown-list)
  (setq yas/prompt-functions '(yas/dropdown-prompt))

;; (define-key yas/minor-mode-map (kbd "C-c y i") 'yas/insert-snippet)
;; (define-key yas/minor-mode-map (kbd "C-c y f") 'yas/find-snippets)
;; (define-key yas/minor-mode-map (kbd "C-c y n") 'yas/new-snippet)
;; (define-key yas/minor-mode-map (kbd "C-c y r") 'yas/reload-all)

(global-set-key "\C-cyi" 'yas/insert-snippet)
(global-set-key "\C-cyf" 'yas/find-snippets)
(global-set-key "\C-cyn" 'yas/new-snippet)
(global-set-key "\C-cyr" 'yas/reload-all)

(global-set-key "\C-cyo" 'yas/register-oneshot-snippet)
(global-set-key "\C-cye" 'yas/expand-oneshot-snippet)
)


;; ffap
;; (ffap-bindings) ; default bindings
(global-set-key "\C-x\C-f" 'find-file-at-point)
(global-set-key "\C-x4f"   'ffap-other-window)
(global-set-key "\C-x5f"   'ffap-other-frame)
(eval-after-load "ffap" '(require 'ffap-perl-module))
(setq ffap-alist nil)                ; faster, dumber prompting
(setq ffap-machine-p-known 'accept)  ; no pinging
(setq ffap-url-regexp nil)           ; disable URL features in ffap
(setq ffap-shell-prompt-regexp nil)  ; disable shell prompt stripping
;;?
(setq ffap-url-fetcher nil) 
;;!?
;;(remove-hook 'find-file-hook 'tramp-set-auto-save)
;;(remove-hook 'kill-buffer-hook 'tramp-flush-file-function)
;;(remove-hook 'kill-buffer-hook 'tramp-delete-temp-file-function)


;; Zen Coding Mode
(when (require 'zencoding-mode nil t)
  (add-hook 'sgml-mode-hook (lambda () (zencoding-mode 1)))
  (add-hook 'html-mode-hook (lambda () (zencoding-mode 1)))
  (add-hook 'text-mode-hook (lambda () (zencoding-mode 1)))
;;  (define-key zencoding-mode-keymap "\C-z" 'zencoding-expand-line)
  (define-key zencoding-mode-keymap "\C-z" 'zencoding-expand-yas)
  (define-key zencoding-preview-keymap "\C-z" 'zencoding-preview-accept)
)
;; インデントがスペースじゃなくてタブになってほしい
(defun zencoding-indent (text)
  "Indent the text"
  (if text
      (replace-regexp-in-string "\n" "\n	" (concat "\n" text))
    nil))




;; C-a で M-m する
(defun my-move-beginning-of-line ()
  (interactive)
  (if (bolp)
      (back-to-indentation)    
      (beginning-of-line)))
(global-set-key "\C-a" 'my-move-beginning-of-line)

;; ;; http://www.emacswiki.org/cgi-bin/wiki/CPerlMode
;; ;; Cperl-mode with ElDoc
;; (defun my-cperl-eldoc-documentation-function ()
;;   "Return meaningful doc string for `eldoc-mode'."
;;   (car
;;    (let ((cperl-message-on-help-error nil))
;; 	 (cperl-get-help))))

;; (add-hook 'cperl-mode-hook
;; 		  (lambda ()
;; 			(set (make-local-variable 'eldoc-documentation-function)
;; 				 'my-cperl-eldoc-documentation-function)))


;; ;; don't use tab for align
;; ;; smarttabsでOK
;; (defadvice align (around align-around)
;;   (let ((indent-tabs-mode nil))
;;     ad-do-it))
;; (defadvice align-regexp (around align-regexp-around)
;;   (let ((indent-tabs-mode nil))
;;     ad-do-it))
;; (ad-activate 'align)
;; (ad-activate 'align-regexp)

;; 保存時に文字コードが変わらないようにする
(setq auto-coding-functions nil)
;; (delete 'sgml-html-meta-auto-coding-function auto-coding-functions)
;; (delete 'sgml-xml-auto-coding-function auto-coding-functions)


;; yahtml-goto-corresponding-*
(add-hook 'html-mode-hook (lambda () (load "html-mode-hook.el")))


;; etags
(setq tags-table-list '("~/project/maruta/TAGS")) ;; listで指定
;; (setq tags-file-name "~/project/maruta/TAGS")


;; 連番
(defun count-string-matches (regexp string)
  (with-temp-buffer
    (insert string)
    (count-matches regexp (point-min) (point-max))))
(defun seq (format-string from to)
  "Insert sequences with FORMAT-STRING.
FORMAT-STRING is like `format', but it can have multiple %-sequences."
  (interactive
   (list (read-string "Input sequence Format: ")
         (read-number "From: " 1)
         (read-number "To: ")))
  (save-excursion
    (loop for i from from to to do
          (insert (apply 'format format-string
                         (make-list (count-string-matches "%[^%]" format-string) i))
                  "\n")))
  (end-of-line))

;; 直前の行をコピーする
(defun duplicate-this-line-forward (n)
  "Duplicates the line point is on.  The point is next line.
 With prefix arg, duplicate current line this many times."
  (interactive "p")
  (when (eq (point-at-eol)(point-max))
    (save-excursion (end-of-line) (insert "\n")))
  (save-excursion
    (beginning-of-line)
    (dotimes (i n)
      (insert-buffer-substring (current-buffer) (point-at-bol)(1+ (point-at-eol))))))
(global-set-key [f5] 'duplicate-this-line-forward)

;;   (defalias 'exit 'save-buffers-kill-emacs)

;; \ を押したときにリストがでるのがうざい
(defun skk-list-chars (&optional arg) (interactive "P"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; comment-style

;; (setq comment-style 'plain)
;; (setq comment-style 'indent)
;; (setq comment-style 'indent-or-triple)
;; (setq comment-style 'aligned)
;; (setq comment-style 'multi-line)
;; (setq comment-style 'extra-line)
;; (setq comment-style 'box)
;; (setq comment-style 'box-multi)

;; /* indent; */
;; /* hoge; */
;; /* hemohemohemo; */

;; /* multi-line;
;;  * hoge;
;;  * hemohemohemo; */

;; /* 
;;  * extra-line;
;;  * hoge;
;;  * hemohemohemo;
;;  */

;; /*****************/
;; /* box;			 */
;; /* hoge;		 */
;; /* hemohemohemo; */
;; /*****************/

;; /*****************
;;  * box-multi;	 *
;;  * hoge;		 *
;;  * hemohemohemo; *
;;  *****************/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; shell
;; (setq explicit-shell-file-name "bash.exe")
;; (setq shell-file-name "sh.exe")
;; (setq shell-command-switch "-c")
;; (modify-coding-system-alist 'process ".*sh\\.exe" '(undecided-dos . euc-japan))

;; srep
(require 'srep)

(global-whitespace-mode 1) ;; 01でも指定済？


;;汎用機の SPF (mule みたいなやつ) には
;;画面を 2 分割したときの 上下を入れ替える swap screen
;;というのが PF 何番かにわりあてられていました。
(defun swap-screen()
  "Swap two screen,leaving cursor at current window."
  (interactive)
  (let ((thiswin (selected-window))
        (nextbuf (window-buffer (next-window))))
    (set-window-buffer (next-window) (window-buffer))
    (set-window-buffer thiswin nextbuf)))
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))
(global-set-key [f2] 'swap-screen)
(global-set-key [S-f2] 'swap-screen-with-cursor)


(defun toggle-indent-tabs-mode()
  (interactive)
  (if indent-tabs-mode
	  (progn (setq indent-tabs-mode nil) (message "indent-tabs-mode: nil"))
	  (progn (setq indent-tabs-mode t) (message "indent-tabs-mode: t"))
	  ))

;; diffの表示方法を変更
(defun diff-mode-setup-faces ()
  ;; 追加された行は緑で表示
  (set-face-attribute 'diff-added nil
                      :foreground "white" :background "dark green")
  ;; 削除された行は赤で表示
  (set-face-attribute 'diff-removed nil
                      :foreground "white" :background "dark red")
  ;; 文字単位での変更箇所は色を反転して強調
  (set-face-attribute 'diff-refine-change nil
                      :foreground nil :background nil
                      :weight 'bold :inverse-video t))
(add-hook 'diff-mode-hook 'diff-mode-setup-faces)

;; diffを表示したらすぐに文字単位での強調表示も行う
(defun diff-mode-refine-automatically ()
  (diff-auto-refine-mode t))
(add-hook 'diff-mode-hook 'diff-mode-refine-automatically)

;; diff関連の設定
(defun magit-setup-diff ()
  ;; diffを表示しているときに文字単位での変更箇所も強調表示する
  ;; 'allではなくtにすると現在選択中のhunkのみ強調表示する
  (setq magit-diff-refine-hunk 'all)
  ;; diff用のfaceを設定する
  (diff-mode-setup-faces)
  ;; diffの表示設定が上書きされてしまうのでハイライトを無効にする
  (set-face-attribute 'magit-item-highlight nil :inherit nil))
(add-hook 'magit-mode-hook 'magit-setup-diff)

;; list-packages リスト追加
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


;; cperl-mode
(setq cperl-auto-newline nil)

;; ;;foreign-regexp
;; (add-to-list 'load-path (expand-file-name "~/bin/emacs/site-lisp/foreign-regexp.el"))
;; (require 'foreign-regexp)
;; (custom-set-variables
;;  '(foreign-regexp/regexp-type 'perl) ;; Choose by your preference.
;;  '(reb-re-syntax 'foreign-regexp)) ;; Tell re-builder to use foreign regexp.


; 全角チルダ/波ダッシュをWindowsスタイルにする
(let ((my-translation-table
    (make-translation-table-from-alist
        '((#x301c . #xff5e)
    ))))
    (mapc
        (lambda (coding-system)
            (coding-system-put coding-system :decode-translation-table my-translation-table)
            (coding-system-put coding-system :encode-translation-table my-translation-table)
        )
    '(utf-8 cp932 utf-16le)))

(setq skk-rom-kana-rule-list '(
    ("z-" nil "～")
))

;; nxml-mode
(setq nxml-child-indent 4)

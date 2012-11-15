
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
(global-set-key "\C-\\" nil) ;; toggle-input-method いらん

;; file-cache
(require 'filecache)
(file-cache-add-directory-list
 (list "~"
       "~/memo"
       "~/svn/marutaportal/trunk/maruta.be/" "~/svn/marutaportal/trunk/maruta.be/public_html/" "~/svn/marutaportal/trunk/maruta.be/data/blog_maruta/html/"
       "~/svn/marutaportal/trunk/maruta.be/data/common/html/service_admin/"
       "~/svn/marutaportal/trunk/maruta.be/lib/IBlog" "~/svn/marutaportal/trunk/maruta.be/lib/IBlog/Data"
       "~/svn/common/dev/lib/perl/"
       ))
(file-cache-add-file-list
 (list "~/svn/marutaportal/trunk/doc/iblog.sql"))
(define-key minibuffer-local-completion-map
  "\C-c\C-i" 'file-cache-minibuffer-complete)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ChangeLog
(require 'add-change-log-entry2)
(defun memo-shogoin ()
  (interactive)
    (add-change-log-entry2
     nil
     (expand-file-name "~/shogoin/memo.txt")
     t))
(global-set-key "\C-cmk" 'memo-shogoin)

(defun memo-imessage ()
  (interactive)
    (add-change-log-entry2
     nil
     (expand-file-name "~/ChangeLog-imessage.txt")
     t))
(global-set-key "\C-cmi" 'memo-imessage)

(defun memo-mebal ()
  (interactive)
    (add-change-log-entry2 
     nil
     (expand-file-name "~/ChangeLog-mebal.txt")
     t))
(global-set-key "\C-cmm" 'memo-mebal)

(defun memo-maruta-site-admin ()
  (interactive)
    (add-change-log-entry2 
     nil
     (expand-file-name "~/maruta/note.txt")
     t))
(global-set-key "\C-cms" 'memo-maruta-site-admin)

(defun memo-eoblog ()
  (interactive)
    (add-change-log-entry2 
     nil
     (expand-file-name "~/eoblog/note.txt")
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


;; ミニバッファの履歴の重複削除＋ファイル履歴から読み込めないファイルを削除
(defun my-minibuffer-delete-duplicate ()
  (let* ((hist (symbol-value minibuffer-history-variable))
         (last (car hist)))
    (when (eq minibuffer-history-variable 'file-name-history)
      ;; $HOME や ".." や "." は正則化する
      (setq last (concat "~/" (file-relative-name 
                               (expand-file-name (car hist)) "~/"))))
    (when (> (length hist) 1)
      (set minibuffer-history-variable (cons last (delete last (cdr hist)))))
    (when (eq minibuffer-history-variable 'file-name-history)
      (unless (file-readable-p last)
        (set minibuffer-history-variable (cdr hist))))))
(add-hook 'minibuffer-setup-hook 'my-minibuffer-delete-duplicate)

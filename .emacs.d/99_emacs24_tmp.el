;; 文字コード指定して開く
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

;; 文字コード指定して保存
(defun changecode-utf8()
  (interactive)
  (set-buffer-file-coding-system 'utf-8-unix)
  (save-buffer))

;; 保存時に文字コードが変わらないようにする
(setq auto-coding-functions nil)


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
	   "~/.emacs.d/"
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

;; C-a で M-m する
(defun my-move-beginning-of-line ()
  (interactive)
  (if (bolp)
      (back-to-indentation)
      (beginning-of-line)))
(global-set-key "\C-a" 'my-move-beginning-of-line)

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


;; yahtml-goto-corresponding-*
(add-hook 'html-mode-hook (lambda () (load "html-mode-hook.el")))

;; etags
(setq tags-table-list '("~/project/maruta/TAGS")) ;; listで指定
;; (setq tags-file-name "~/project/maruta/TAGS")

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


;; 画面分割したときの上下を入れ替える
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

;; nxml-mode
(setq nxml-child-indent 4)

;; tramp
;(setenv "PATH"
;  (concat "C:\\Users\\hasebe\\bin\\PuTTY" ";" (getenv "PATH")))
(setq-default tramp-default-method "plink")

;; textile(redmine)
(require 'textile-mode nil t)

(add-to-list 'load-path "C:/Users/hasebe/.emacs.d/elpa/twittering-mode-3.0.0")
(require 'twittering-mode)
(setq twittering-icon-mode nil)
(setq twittering-auth-method 'xauth)
(setq twittering-username "hebon")
;(setq twittering-password "")
(setq twittering-initial-timeline-spec-string
      '(
;        ":home" ":replies" ":favorites" ":direct_messages" ":search/emacs/"
        "hebon/rom"))

;; org-mode
(setq org-export-html-style-include-scripts nil)
(setq org-export-html-style-include-default nil)
(setq org-export-html-validation-link nil)

;;; -*- mode: lisp-interaction; syntax: elisp -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; JAPANESE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; unicode
  (utf-translate-cjk-set-unicode-range
   '((#x00a2 . #x00a3) ; ￠, ￡
     (#x00a7 . #x00a8) ; §, ¨
     (#x00ac . #x00ac) ; ￢
     (#x00b0 . #x00b1) ; °, ±
     (#x00b4 . #x00b4) ; ´
     (#x00b6 . #x00b6) ; ¶
     (#x00d7 . #x00d7) ; ×
     (#X00f7 . #x00f7) ; ÷
     (#x0370 . #x03ff) ; Greek and Coptic
     (#x0400 . #x04FF) ; Cyrillic
     (#x2000 . #x206F) ; General Punctuation
     (#x2100 . #x214F) ; Letterlike Symbols
     (#x2190 . #x21FF) ; Arrows
     (#x2200 . #x22FF) ; Mathematical Operators
     (#x2300 . #x23FF) ; Miscellaneous Technical
     (#x2500 . #x257F) ; Box Drawing
     (#x25A0 . #x25FF) ; Geometric Shapes
     (#x2600 . #x26FF) ; Miscellaneous Symbols
     (#x2e80 . #xd7a3) (#xff00 . #xffef)))
(eval-after-load "subst-jis" '(load "subst-jisx0208ex"))

;; 日本語環境設定
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8-unix)
(setq default-file-name-coding-system 'shift_jis) ; 日本語ファイル名＠Windows

;; 波ダッシュ対応 (Windows)
(when (require 'un-supple nil t)
  (un-supple-enable 'windows))

;; SKK
(require 'skk-autoloads)
;; SKK.tut と辞書ファイルの場所を指定
(setq skk-tut-file "C:/Meadow/packages/etc/skk/SKK.tut")
(setq skk-large-jisyo "C:/Meadow/packages/etc/skk/SKK-JISYO.L")
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-mode)
;;(global-set-key "\C-xt" 'skk-tutorial)
(setq skk-kutouten-type 'jp)

;; skk-isearch
(add-hook 'isearch-mode-hook
          (function (lambda ()
                      (and (boundp 'skk-mode) skk-mode
                           (skk-isearch-mode-setup)))))
(add-hook 'isearch-mode-end-hook
          (function (lambda ()
                      (and (boundp 'skk-mode) skk-mode
                           (skk-isearch-mode-cleanup)
                           (skk-set-cursor-color-properly)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; INTERFACE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 起動時のメッセージを消す
(setq inhibit-startup-message t)

;; ツールバー非表示
(tool-bar-mode -1)

;; カーソル位置表示
(setq column-number-mode t)

;; マウスカーソルを消す設定
(setq w32-hide-mouse-on-key t)
(setq w32-hide-mouse-timeout 5000)

;; font-lockの設定
(global-font-lock-mode t)

;; Tab と Space を強調
(defface my-face-b-1 '((t (:background "LightBlue"))) nil)
(defface my-face-b-2 '((t (:background "#e0e0e0"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
;;     ("[ \t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;; 初期フレームの設定
(setq default-frame-alist
      (append (list '(foreground-color . "black")
                    '(background-color . "LemonChiffon")
                    '(border-color . "black")
                    '(mouse-color . "white")
                    '(cursor-color . "black")
                    '(font . "MS Gothic 14")
                    '(width . 80)
                    '(height . 40)
                    '(top . 0)
                    '(left . 100))
              default-frame-alist))

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t)

(defun scroll-up-one-line ()
  (interactive)
  (scroll-up 1))
(defun scroll-down-one-line ()
  (interactive)
  (scroll-down 1))
(global-set-key [?\C-,] 'scroll-up-one-line)
(global-set-key [?\C-.] 'scroll-down-one-line)

;; shift+カーソルキーでウインドウ間を移動
(windmove-default-keybindings)
(setq windmove-wrap-around t)

;; 縦分割したときもおりかえし
(setq truncate-partial-width-windows nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GENERAL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; shell 関係
;; argument-editing の設定
(require 'mw32script)
(mw32script-init)

;; バックアップいらん
(setq make-backup-files nil)

;; indent
(setq-default tab-width 4 
              indent-tabs-mode t) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; MAJOR MODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; RefTeX (YaTeX)
(cond
 ((locate-library "yatex")
  (autoload 'yatex-mode
    "yatex" "Yet Another LaTeX mode" t)
  ;; RefTeX 起動
  (add-hook 'yatex-mode-hook '(lambda () (reftex-mode t)))
  ;; 拡張子が .tex のファイルを開くときに yatex-mode にする
  (setq auto-mode-alist
    (cons '("\\.tex$" . yatex-mode) auto-mode-alist))))
;; 漢字コード 1=Shift JIS, 2=JIS, 3=EUC
(setq YaTeX-kanji-code 2)

;; yahtml-mode
(autoload 'yahtml-mode "yahtml" "Yet Another HTML mode" t)
(setq auto-mode-alist (cons (cons "\\.html?$" 'yahtml-mode) auto-mode-alist))
(setq yahtml-lint-program "htmllint")
(setq yahtml-kanji-code 4) ; (1 sjis, 2 jis, 3 euc) ; added 4:utf-8
(setq yahtml-environment-indent 4)
(setq yahtml-fill-column nil)
;(setq fill-column 1000)
(add-hook 'yahtml-mode-hook '(lambda () (setq fill-column 1000)))
(setq yahtml-www-browser "~/bin/sleipnir2/bin/Sleipnir.exe") ; ブラウザ (C-t p でプレビュ)

;; cperl-mode
(autoload 'perl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(setq cperl-indent-level 4)
(setq cperl-continued-statement-offset 4)
(setq auto-mode-alist 
      (cons (cons "\\(\\.pl\\|\\.pm\\|\\.f?cgi\\)$" 'cperl-mode)
            auto-mode-alist))
(add-hook 'cperl-mode-hook
 '(lambda()(set-face-italic-p 'cperl-hash-face nil)))

;; css-mode (要インストール)
(autoload 'css-mode "css-mode")
(setq auto-mode-alist (cons '("\\.css$" . css-mode) auto-mode-alist))
;;(setq cssm-indent-function #'cssm-c-style-indenter)
;;(setq cssm-indent-level 4)
(setq css-indent-level 4)

;; js
(setq auto-mode-alist (cons '("\\.js$" . java-mode) auto-mode-alist))

;; php-mode (要インストール)
;;(load-library "php-mode") 
;;(require 'php-mode) 

;; pod-mode (要インストール)
;;(require 'pod-mode)
;;(setq auto-mode-alist
;;    (append auto-mode-alist
;;            '(("\\.pod$" . pod-mode))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; USEFUL (for PROGRAMMING)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 対応する括弧へ飛ぶ (%)
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))


;; for ChangeLog (C-x 4 a (default))
(setq user-full-name "Mai Hasebe")
(setq user-mail-address "hasebe@intfloat.com")
(defun memo ()
  (interactive)
    (add-change-log-entry 
     nil
     (expand-file-name "~/ChangeLog.txt")))
(define-key ctl-x-map "M" 'memo)

;; info-lookup
(setq Info-directory-list
      (append
       Info-default-directory-list
       (list
        (expand-file-name "~/info")
        )
       ))
(eval-after-load "info-look"
  '(progn
     (info-lookup-add-help
      :topic 'symbol
      :mode 'sql-mode
      :regexp "[^()`',\"\t\n]+"
      :ignore-case t
      :doc-spec '(("(mysql)Function Index" nil " - [^:]+: "))
      :parse-rule "[^()`',\" \t\n]+"
      :other-modes nil)
     (info-lookup-add-help
      :topic 'symbol
      :mode 'cperl-mode
      :regexp "[^()`',\"\t\n]+"
      :ignore-case t
      :doc-spec '(("(perl-ja)Function Index" nil " - [^:]+: "))
      :parse-rule "[^()`',\" \t\n]+"
      :other-modes nil)
))
;; info-lookup (default C-h C-S)
(define-key help-map "\C-i" 'info-lookup-symbol)


;; perltidy (C-c t)
(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
(define-key global-map "\C-ct" 'perltidy-region)

;; perleval
(defun perl-eval (beg end)
  "Run selected region as Perl code"
  (interactive "r")
  (save-excursion
  (shell-command-on-region beg end "perl")))
(define-key global-map "\C-cp" 'perl-eval)
(define-key global-map "\C-c\C-p" 'perl-eval)

;; perl syntax check
(defun perlwc()
  (interactive)
  (shell-command (concat "perl -wc " (file-name-nondirectory (buffer-file-name)))))
(defun perlc()
  (interactive)
  (shell-command (concat "perl -c " (file-name-nondirectory (buffer-file-name)))))


;; 補完 (M-SPC) abbrev-mode なら自動展開
;; dabbrev は M-/ (default)
;; M-x edit-abbrevs とかで
(quietly-read-abbrev-file)
(setq save-abbrevs t)
(setq abbrev-file-name "~/.abbrev_defs")
(define-key esc-map  " " 'expand-abbrev)
;; abbrev-mode
;; (add-hook 'cperl-mode-hook '(lambda () (abbrev-mode 1)))
(require 'expand)
;; ;; 自動で展開しない
;; (add-hook 'pre-command-hook
;;          (lambda ()
;;            (setq abbrev-mode nil)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; MISC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; iswitchb
;; ;; emacs21
;;(iswitchb-default-keybindings)
;;(define-key global-map "\C-c\C-xb" 'switch-to-buffer)
;; emacs22
(iswitchb-mode 1)
(global-set-key "\C-x\C-b" 'electric-buffer-list) 
(eval-after-load "ebuff-menu"
  '(progn
     (define-key
       electric-buffer-menu-mode-map
       "x" 'Buffer-menu-execute)))

;; w3m の cookie
(setq w3m-use-cookies t)

;; moccur, moccur-edit
(when (require 'color-moccur nil t)
  (load "moccur-edit")
  ;; ~, .svnを無視
  (setq dmoccur-exclusion-mask
        (append '("\\~$" "\\.svn\\/\*") dmoccur-exclusion-mask)))

;; imenu
(add-hook 'cperl-mode-hook 'imenu-add-menubar-index) 

;; face2html
(autoload 'face2html "face2html" nil t)

;; wdired
(when (require 'wdired nil t)
  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode))

;; anything (emacs 22-)
;;(require 'anything-config)

;; which-function
(which-function-mode t)

;; mouse-wheel
(setq mouse-wheel-progressive-speed nil)

;;recentf
;; (recentf-mode 1)
;; (global-set-key "\C-cr" 'recentf-open-files) 


;; session.el + minibuf-isearch
;; ミニバッファ履歴リストの最大長：tなら無限
(setq history-length 200)
;; session.el
;;   kill-ringやミニバッファで過去に開いたファイルなどの履歴を保存する
(when (require 'session nil t)
  (setq session-initialize '(de-saveplace session keys menus places)
        session-globals-include '((kill-ring 0)
                                  (session-file-alist 50 t)
                                  (file-name-history 200)))
  (add-hook 'after-init-hook 'session-initialize)
  ;; 前回閉じたときの位置にカーソルを復帰
  (setq session-undo-check -1))
;; minibuf-isearch
;;   minibufでisearchを使えるようにする
(require 'minibuf-isearch nil t)


;;(require 'psvn)

;; auto-complete
;;(require 'auto-complete)
;;(global-auto-complete-mode t)

;; 行コピー
(defun copy-line (&optional numlines)
  (interactive "p")
  (save-excursion
    (let* ((col (current-column))
           (bol (progn (beginning-of-line) (point)))
           (eol (progn (end-of-line) (point)))
           (line (buffer-substring bol eol)))
      (kill-ring-save bol eol)
      (message "save line to kill-ring"))))
(global-set-key "\C-c\C-w" 'copy-line)
(add-hook 'cperl-mode-hook '(lambda() (progn (define-key cperl-mode-map "\C-c\C-w" 'copy-line))))

;; alignはスペースでindentはタブ
(require 'smarttabs nil t)

;; 他はここにいれとく
(load "99_emacs22_tmp.el")


;;;
;;; end of file
;;;
(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(case-fold-search t)
; '(current-language-environment "Japanese")
; '(default-input-method "japanese")
 '(global-font-lock-mode t nil (font-lock))
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )

(put 'downcase-region 'disabled nil)

(put 'upcase-region 'disabled nil)

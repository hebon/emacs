;;; -*- mode: lisp-interaction; syntax: elisp -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; JAPANESE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;!
(setq auto-install-use-wget nil)

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
;(setq skk-tut-file "C:/Meadow/packages/etc/skk/SKK.tut")
;(setq skk-large-jisyo "C:/Meadow/packages/etc/skk/SKK-JISYO.L")
;(setq skk-large-jisyo "~/bin/emacs/etc/skk/SKK-JISYO.L")
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

;; ;; Tab と Space を強調
;; (defface my-face-b-1 '((t (:background "LightBlue"))) nil)
;; (defface my-face-b-2 '((t (:background "#e0e0e0"))) nil)
;; (defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
;; (defvar my-face-b-1 'my-face-b-1)
;; (defvar my-face-b-2 'my-face-b-2)
;; (defvar my-face-u-1 'my-face-u-1)
;; (defadvice font-lock-mode (before my-font-lock-mode ())
;;   (font-lock-add-keywords
;;    major-mode
;;    '(("\t" 0 my-face-b-2 append)
;;      ("　" 0 my-face-b-1 append)
;; ;;     ("[ \t]+$" 0 my-face-u-1 append)
;;      )))
;; (ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
;; (ad-activate 'font-lock-mode)

;; emacs23 以降は global-whitespace-mode で対応
(require 'whitespace)
(setq whitespace-space-regexp "\\(\x3000+\\)") ; スペースの定義は全角スペースとする。
(setq whitespace-style '(face tabs spaces)) ; emacs23.3 以降は face が必要らしい
(set-face-background 'whitespace-space "LightBlue")
(set-face-background 'whitespace-tab "#e0e0e0")
(global-whitespace-mode 1)


;; 初期フレームの設定
(setq default-frame-alist
      (append (list '(foreground-color . "black")
                    '(background-color . "LemonChiffon")
                    '(border-color . "black")
                    '(mouse-color . "white")
                    '(cursor-color . "black")
                    '(font . "MS Gothic 10")
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

;; バックアップいらん
(setq make-backup-files nil)

;; indent
(setq-default tab-width 4 
              indent-tabs-mode t) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; USEFUL (for PROGRAMMING)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;;recentf
(recentf-mode 1)
(setq recentf-max-saved-items 50)
;; (global-set-key "\C-cr" 'recentf-open-files) 

;; anything (emacs 22-)
;;(require 'anything-config)
(when (require 'anything-startup nil t)
  (global-set-key "\C-xf" 'anything-for-files) ; anything-find-file: C-xC-f
  (global-set-key "\C-xb" 'anything-for-buffers) ; iswitchb
)


;; which-function
(which-function-mode t)

;; mouse-wheel
(setq mouse-wheel-progressive-speed nil)


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

;; なんかminibuf-isearchでエラーでる
(setq minibuf-isearch-use-migemo nil)


;;(require 'psvn)

;; auto-complete
;;(require 'auto-complete)
;;(global-auto-complete-mode t)


;; auto-install
(require 'auto-install)
;(setq auto-install-directory "~/bin/emacs/site-lisp/auto-install/")
(setq auto-install-directory "~/.emacs.d/auto-install/")
(add-to-list 'load-path "~/.emacs.d/auto-install/")
;(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;; alignはスペースでindentはタブ
(require 'smarttabs nil t)
;; (defadvice align (around align-around)
;;   (let ((indent-tabs-mode nil))
;;     ad-do-it))
;; (defadvice align-regexp (around align-regexp-around)
;;   (let ((indent-tabs-mode nil))
;;     ad-do-it))
;; (ad-activate 'align)
;; (ad-activate 'align-regexp)


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

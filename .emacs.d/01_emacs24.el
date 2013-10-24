;;; -*- mode: lisp-interaction; syntax: elisp -*-

;; list-packages リスト追加
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; JAPANESE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 日本語環境設定
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8-unix)
(setq default-file-name-coding-system 'shift_jis) ; 日本語ファイル名＠Windows

;; 波ダッシュ対応 (Windows)
(when (require 'un-supple nil t)
  (un-supple-enable 'windows))

;; 全角チルダ/波ダッシュをWindowsスタイルにする
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

;; 文字コード 機種依存文字 ～①㈱©
(require 'cp5022x)

;; SKK
(require 'skk-autoloads)
(global-set-key "\C-x\C-j" 'skk-mode)
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

;; \ を押したときにリストがでるのがうざい
(defun skk-list-chars (&optional arg) (interactive "P"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; INTERFACE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 起動時のメッセージを消す
(setq inhibit-startup-message t)

;; ツールバー非表示
(tool-bar-mode -1)

;; カーソル位置表示
(setq column-number-mode t)

;; font-lockの設定
(global-font-lock-mode t)

;; タブ、スペースを強調
(require 'whitespace)
(setq whitespace-space-regexp "\\(\x3000+\\)") ; スペースの定義は全角スペースとする。
(setq whitespace-style '(face tabs spaces trailing))
(set-face-background 'whitespace-space "LightBlue")
(set-face-background 'whitespace-tab "#e0e0e0")
(set-face-background 'whitespace-trailing "gold2")
(global-whitespace-mode 1)

;; 初期フレームの設定
(setq default-frame-alist
      (append (list '(foreground-color . "black")
                    '(background-color . "LemonChiffon")
                    '(font . "MS Gothic 10")
                    )
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
(setq abbrev-file-name "~/.emacs.d/.abbrev_defs")
(define-key esc-map  " " 'expand-abbrev)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; MISC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; iswitchb
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

;; alignはスペースでindentはタブ
(require 'smarttabs nil t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; MAJOR MODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; yahtml-mode
(autoload 'yahtml-mode "yahtml" "Yet Another HTML mode" t)
;!(setq auto-mode-alist (cons (cons "\\(\\.html?\\|\\.tt2?n?\\)$" 'yahtml-mode) auto-mode-alist))
(setq yahtml-lint-program "htmllint")
(setq yahtml-kanji-code 4) ; (1 sjis, 2 jis, 3 euc) ; added 4:utf-8
(setq yahtml-environment-indent 4)
(setq yahtml-fill-column nil)
;(setq fill-column 1000)
(add-hook 'yahtml-mode-hook '(lambda () (setq fill-column 1000)))
(setq yahtml-www-browser "~/bin/sleipnir2/bin/Sleipnir.exe") ; ブラウザ (C-t p でプレビュ)

;; html-mode
(add-hook 'sgml-mode-hook (lambda () (setq sgml-basic-offset 4)))
(setq auto-mode-alist (cons (cons "\\(\\.html?\\|\\.tt2?n?\\)$" 'html-mode) auto-mode-alist))

;; ;; web-mode
;; (autoload 'web-mode "web-mode")
;; (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; ;;; インデント数
;; (defun web-mode-hook ()
;;   "Hooks for Web mode."
;;   (setq web-mode-html-offset   4)
;;   (setq web-mode-css-offset    4)
;;   (setq web-mode-script-offset 4))
;; (add-hook 'web-mode-hook 'web-mode-hook)


;; cperl-mode
;(autoload 'perl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(defalias 'perl-mode 'cperl-mode)
(setq cperl-indent-level 4)
(setq cperl-continued-statement-offset 4)
(setq auto-mode-alist
      (cons (cons "\\(\\.pl\\|\\.pm\\|\\.f?cgi\\)$" 'cperl-mode)
            auto-mode-alist))

(add-hook 'cperl-mode-hook
 '(lambda()(set-face-italic-p 'cperl-hash-face nil)))
(setq cperl-electric-backspace-untabify nil)
(setq cperl-auto-newline nil)

;; css-mode (要インストール)
(autoload 'css-mode "css-mode")
(setq auto-mode-alist (cons '("\\.css$" . css-mode) auto-mode-alist))
(setq css-indent-level 4)

;; js
(setq auto-mode-alist (cons '("\\.js$" . js-mode) auto-mode-alist))

;;php-mode (要インストール)
(autoload 'php-mode "php-mode")

;; YAML
(autoload 'yaml-mode "yaml-mode")
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; ;; Trac
;; (autoload 'moinmoin-mode "moinmoin-mode" nil t)
;; ;(add-hook 'moinmoin-mode-hook
;; ; '(lambda()(set-face-height 'cperl-hash-face nil)))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(moinmoin-url ((t (:foreground "blue2")))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; USEFUL FUNCTIONS
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
(setq user-full-name "")
(setq user-mail-address "")
(defun memo ()
  (interactive)
    (add-change-log-entry
     nil
     (expand-file-name "~/ChangeLog.txt")))
(define-key ctl-x-map "M" 'memo)


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
(add-hook 'python-mode-hook '(lambda() (progn (define-key python-mode-map "\C-c\C-w" 'copy-line))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; perl
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; perltidy (C-c t)
(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
(define-key global-map "\C-ct" 'perltidy-region)

;; perltidy (pbp)
(defun perltidy-region-pbp ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidypbp -q" nil t)))
(defalias 'pbp 'perltidy-region-pbp)

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

(defun perltidy-file-pbp()
  (interactive)
  (shell-command (concat "pbp.bat " (file-name-nondirectory (buffer-file-name))))
  (find-alternate-file (file-name-nondirectory (buffer-file-name))))

(defun perldoc()
  (interactive)
  (shell-command (concat "/usr/bin/perldoc " (file-name-nondirectory (buffer-file-name)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 入力支援系
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; yasnippet
(when (require 'yasnippet nil t)

  ;; oneshot-snippet
  (require 'yasnippet-config)

  (yas/initialize)
  (setq yas/root-directory "~/.emacs.d/snippets")
  (yas/load-directory yas/root-directory)
  (require 'dropdown-list)
  (setq yas/prompt-functions '(yas/dropdown-prompt))

  (global-set-key "\C-cyi" 'yas/insert-snippet)
  (global-set-key "\C-cyf" 'yas/find-snippets)
  (global-set-key "\C-cyn" 'yas/new-snippet)
  (global-set-key "\C-cyr" 'yas/reload-all)

  (global-set-key "\C-cyo" 'yas/register-oneshot-snippet)
  (global-set-key "\C-cye" 'yas/expand-oneshot-snippet)
)

;;;; for new version (0.8.0)
;; (when (require 'yasnippet nil t)
;;   (setq yas-snippet-dirs
;; 		'(
;; 		  "~/.emacs.d/snippets"
;; 		  ;;"~/.emacs.d/elpa/yasnippet-20131021.928/snippets"
;; 		  ))
;;   (yas-global-mode 1)
;;   ;; (custom-set-variables '(yas-trigger-key "TAB"))
;; )


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

;; 連番作成
(require 'srep)

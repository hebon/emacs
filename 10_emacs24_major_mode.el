;;; -*- mode: lisp-interaction; syntax: elisp -*-

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

;; css-mode (要インストール)
(autoload 'css-mode "css-mode")
(setq auto-mode-alist (cons '("\\.css$" . css-mode) auto-mode-alist))
;;(setq cssm-indent-function #'cssm-c-style-indenter)
;;(setq cssm-indent-level 4)
(setq css-indent-level 4)

;; js
(setq auto-mode-alist (cons '("\\.js$" . js-mode) auto-mode-alist))

;;php-mode (要インストール)
(load-library "php-mode") 
(require 'php-mode) 

;; pod-mode (要インストール)
;;(require 'pod-mode)
;;(setq auto-mode-alist
;;    (append auto-mode-alist
;;            '(("\\.pod$" . pod-mode))))

;; YAML
(autoload 'yaml-mode "yaml-mode")
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; (add-hook ‘yaml-mode-hook
;; 			(function
;; 			 (lambda ()
;; 			   (set (make-local-variable ‘indent-tabs-mode) nil)
;; 			   )))

;; Trac
(autoload 'moinmoin-mode "moinmoin-mode" nil t)
;(add-hook 'moinmoin-mode-hook
; '(lambda()(set-face-height 'cperl-hash-face nil)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(moinmoin-url ((t (:foreground "blue2")))))


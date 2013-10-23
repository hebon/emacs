;; (add-to-list 'load-path "~/emacs_settings")
;; (load-file "~/emacs_settings/00_init.el")

(add-to-list 'load-path "~/.emacs.d")
(load-file "~/.emacs.d/00_init.el")

; for cygwin perl
(setenv "LC_ALL" "C")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(case-fold-search t)
 '(column-number-mode t)
 '(global-font-lock-mode t nil (font-lock))
 '(safe-local-variable-values (quote ((syntax . elisp))))
 '(save-place t nil (saveplace))
 '(transient-mark-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

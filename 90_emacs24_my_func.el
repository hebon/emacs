;;; -*- mode: lisp-interaction; syntax: elisp; coding:utf-8 -*-

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
(setq user-full-name "Mai Hasebe")
(setq user-mail-address "hasebe@intfloat.com")
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

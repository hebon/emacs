;;; fswiki-mode.el --- Major mode for editing FreeStyleWiki text in Emacs

;; Copyright (C) 1994, 1995, 1996 1997, 1998, 1999, 2000, 2001,
;;   2002,2003, 2004, 2005, 2006, 2007, 2008
;;   Free Software Foundation, Inc.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This file is not part of GNU Emacs.

;; It is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.

;; You should have received a copy of the GNU General Public License
;; along with it.  If not, see <http://www.gnu.org/licenses/>.

;; Authors: Koh Uehara <refluster@gmail.com>
;; URL: 
;; Created: 18 Jul 2009
;; Last modified: 27 Nov 2011
;; Keywords: markup fswiki
;; Version: 0.1.0

;;; Commentary:

;; To use graphviz-dot-mode, add 
;; (load-file "PATH_TO_FILE/fswiki-mode.el")
;; to your ~/.emacs(.el) or ~/.xemacs/init.el

;;; code:

(defun fswiki-get-current-line ()
  (buffer-substring
   (save-excursion (beginning-of-line) (point))
   (save-excursion (end-of-line) (point))))

(defun fswiki-newline-with-same-mark ()
  (interactive)
  (let ((line (fswiki-get-current-line)))
    (if (string-match 
	 "^!+\\|^\"\"\\|^:+\\|^\\*+\\|^\\++\\|^,\\|^ \\|^----\\|^//"
	 line)
	(progn
	  (insert
	   (concat "\n" (match-string 0 line))))
      (insert "\n"))))

(defun fswiki-insert-string-to-beginning-of-line (s)
  (save-excursion
    (beginning-of-line)
    (insert-before-markers s)))

(defun fswiki-mark-add ()
  (interactive)
  (let ((line (fswiki-get-current-line)))
    (cond
     ;; increment depth level
     ((string-match "^!\\|^:\\|^\\*\\|^\\+" line)
      (fswiki-insert-string-to-beginning-of-line
       (substring line 0 1)))
     ;; do not modify
     ((string-match "^\"\"\\|^ \\|^----\\|^//" line)
      nil)
     ;; add column (table)
     ((string-match "^," line)
      (insert ","))
     ;; select mark and add
     (t (message
	 "select mark:\n%-16s %-16s %-16s\n%-16s %-16s %-16s\n%-16s %-16s %-16s"
	 "s) section" "c) citacion" "d) description" "i) itemize" "e) enumerate"
	 "t) table" "v) verbatim" "-) hline" "/) comment")
	(fswiki-insert-string-to-beginning-of-line
	 (let ((c (downcase (read-char))))
	   (cond ((eq c ?s) "!")
		 ((eq c ?c) "\"\"")
		 ((eq c ?d) ":")
		 ((eq c ?i) "*")
		 ((eq c ?e) "+")
		 ((eq c ?t) ",")
		 ((eq c ?v) " ")
		 ((eq c ?-) "----")
		 ((eq c ?/) "//")
		 (t "")
		 )))
	))))

(defun fswiki-mark-delete ()
  (interactive)
  (let ((line (fswiki-get-current-line)))
    (cond 
     ;; decrement the depth level
     ((string-match "^!\\|^:\\|^\\*\\|^\\+\\|^," line)
      (save-excursion
	(beginning-of-line)
	(delete-char 1)))
     ;; delete mark
     ((string-match "^\"\"\\| \\|----\\|//" line)
      (save-excursion
	(beginning-of-line)
	(delete-char (- (match-end 0) (match-beginning 0)))))
     )))

(defun fswiki-comment-paragraph ()
  (interactive)
  (beginning-of-line)
  (if (string= (buffer-substring (point) (+ (point) 2)) "//")
      (message "Already commented out")
    (save-excursion
    (let ((p2 (progn (end-of-paragraph-text) (point)))
	  (p1 (progn (start-of-paragraph-text) (point))))
      (fswiki-comment-region p1 p2)))))
  
(defun fswiki-uncomment-paragraph ()
  (interactive)
  (beginning-of-line)
  (if (string= (buffer-substring (point) (+ (point) 2)) "//")
      (save-excursion
	(let ((p2 (progn (end-of-paragraph-text) (point)))
	      (p1 (progn (start-of-paragraph-text) (point))))
	  (fswiki-uncomment-region p1 p2)))
    (message "This line is not a comment line")))
  
(defun fswiki-comment-region (p1 p2)
  (interactive "r")
  (save-excursion
    (goto-char (- p2 1))
    (while (>= (point) p1)
    (beginning-of-line)
    (insert "//")
    (previous-line 1)
    )))
  
(defun fswiki-uncomment-region (p1 p2)
  (interactive "r")
  (save-excursion
    (goto-char (- p2 1))
    (while (>= (point) p1)
    (beginning-of-line)
    (if (string= 
	 (buffer-substring (point) (+ (point) 2)) "//")
	(delete-char 2))
    (previous-line 1)
    )))

(defun fswiki-set-keymap ()
  (setq fswiki-mode-map (make-keymap))
  (use-local-map fswiki-mode-map)
  (define-key fswiki-mode-map "\C-c." 'fswiki-comment-region)
  (define-key fswiki-mode-map "\C-c," 'fswiki-uncomment-region)
  (define-key fswiki-mode-map "\C-c[" 'fswiki-mark-delete)
  (define-key fswiki-mode-map "\C-c]" 'fswiki-mark-add)
  (define-key fswiki-mode-map "\C-j" 'fswiki-newline-with-same-mark))

(defun fswiki-set-font-lock ()
  (make-face 'fswiki-face-header)
  (set-face-foreground 'fswiki-face-header "#ffff00")
  (set-face-background 'fswiki-face-header "#6a5acd")

  (font-lock-add-keywords 
   nil '(
	 ;; header
	 ("^!+.*$" . 'fswiki-face-header)
	 ;; citation
	 ("^\"\".*$" . font-lock-string-face)
	 ;; description
	 ("^:.*$" . font-lock-type-face)
	 ;; list
	 ("^\\*.*$" . font-lock-constant-face)
	 ;; nlist
	 ("^\\+.*$" . font-lock-constant-face)
	 ;; table
	 ("^,.*$" . font-lock-constant-face)
	 ;; verbatim
	 ("^ .*$" . font-lock-builtin-face)
	 ;; plugin
	 ("^{{.*}}" . 'bold)
	 ;; hline
	 ("^----.*$" . font-lock-constant-face)
	 ;; comment
	 ("^//.*$" . font-lock-comment-face)
	 ;; link
	 ("\\[.*\\]" . 'link)
	 ))
  ;;(global-font-lock-mode)
  (setq font-lock-support-mode t))

(defun fswiki-mode ()
  "Major mode for editing FreeStyleWiki text.
Turning on text-mode runs the hook `fswiki-mode-hook'.

Special commands: 
\\{fswiki-mode-map}
"
  (interactive)
  (kill-all-local-variables)
  
  ;;  (setq local-abbrev-table fswiki-mode-abbrev-table)
  (set-syntax-table text-mode-syntax-table)
  (make-local-variable 'paragraph-start)
  (make-local-variable 'paragraph-separate)

  (setq paragraph-start (concat "[ \t]*$\\|" page-delimiter))
  (setq paragraph-separate paragraph-start)
  
  (setq mode-name "FreeStyleWiki")
  (setq major-mode 'fswiki-mode)
  
  (fswiki-set-keymap)
  (fswiki-set-font-lock)
  
  (run-hooks 'fswiki-mode-hook))

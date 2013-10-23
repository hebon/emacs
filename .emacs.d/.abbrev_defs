;;-*-coding: emacs-mule;-*-
(define-abbrev-table 'apropos-mode-abbrev-table '(
    ))

(define-abbrev-table 'c++-mode-abbrev-table '(
    ("catch" "catch" c-electric-continued-statement 0)
    ("else" "else" c-electric-continued-statement 0)
    ("while" "while" c-electric-continued-statement 0)
    ))

(define-abbrev-table 'c-mode-abbrev-table '(
    ("else" "else" c-electric-continued-statement 0)
    ("while" "while" c-electric-continued-statement 0)
    ))

(define-abbrev-table 'change-log-mode-abbrev-table '(
    ))

(define-abbrev-table 'comint-mode-abbrev-table '(
    ))

(define-abbrev-table 'cperl-mode-abbrev-table '(
    ("continue" "continue" cperl-electric-else 0)
    ("do" "do" cperl-electric-keyword 0)
    ("else" "else" cperl-electric-else 1)
    ("elsif" "elsif" cperl-electric-keyword 1)
    ("foreach" "foreach" cperl-electric-keyword 8)
    ("foreachmy" "foreachmy" cperl-electric-keyword 0)
    ("head1" "head1" cperl-electric-pod 0)
    ("head2" "head2" cperl-electric-pod 0)
    ("if" "if" cperl-electric-keyword 6)
    ("joi" ["join( '', );" 6 (12 7 11) nil] expand-abbrev-hook 0)
    ("ope" ["open(,\"\")	|| die \"$f: Can't open [$]\";" 33 (38 6 8 36) nil] expand-abbrev-hook 0)
    ("over" "over" cperl-electric-pod 0)
    ("pod" "pod" cperl-electric-pod 2)
    ("sub" ["sub _($){
	my $p = $_[0];

}
" 26 nil nil] expand-abbrev-hook 15)
    ("unless" "unless" cperl-electric-keyword 0)
    ("until" "until" cperl-electric-keyword 0)
    ("while" "while" cperl-electric-keyword 1)
    ))

(define-abbrev-table 'emacs-lisp-mode-abbrev-table '(
    ("aut" ["(autoload ' \"\" t t)
" 9 (20 12 14) nil] expand-abbrev-hook 0)
    ("defa" ["(defadvice   (around   act)
  \"\"
  
  )" 28 (39 12 22 32 36) nil] expand-abbrev-hook 0)
    ("defc" ["(defconst   nil
  \"\")
" 12 (22 11 13 20) nil] expand-abbrev-hook 0)
    ("defm" ["(defmacro  ()
  \"\"
  (` 
    ))" 21 (31 11 13 18 25) nil] expand-abbrev-hook 0)
    ("defs" ["(defsubst   ()
  \"\"
  (interactive)
  )" 29 (39 11 14 19 23 39) nil] expand-abbrev-hook 0)
    ("defu" ["(defun   ()
  \"\"
  (interactive)
  (let* (
         )
    
    ))" 58 (65 8 11 16 32 43 59) nil] expand-abbrev-hook 0)
    ("defv" ["(defvar   nil
  \"\")
" 12 (20 9 11 18) nil] expand-abbrev-hook 0)
    ("let" ["(let* (
)
    " 7 (14 8 13) nil] expand-abbrev-hook 0)
    ("sav" ["(save-excursion
 
)" 2 (19 18) nil] expand-abbrev-hook 0)
    ))

(define-abbrev-table 'eshell-mode-abbrev-table '(
    ))

(define-abbrev-table 'ftp-mode-abbrev-table '(
    ("anon" "anonymous" nil 0)
    ("g" "get" nil 0)
    ("p" "prompt" nil 0)
    ("q" "quit" nil 0)
    ))

(define-abbrev-table 'fundamental-mode-abbrev-table '(
    ))

(define-abbrev-table 'global-abbrev-table '(
    ("carp" "use CGI::Carp qw(fatalsToBrowser);" nil 0)
    ("content" "Content-Type: text/html\\n\\n\";" nil 7)
    ("date" "ITK2::getDateTimeString(time(), 'YYYY-MM-DD hh:mm:ss');" nil 0)
    ("dump" "use Data::Dumper;
print \"Content-Type: text/html\\n\\n<plaintext>\";
print Dumper();" nil 1)
    ("itmpl" "new ITmpl({session => 1, fcgi => 1, db_info => $CONFIG{DB_INFO}});" nil 0)
    ("lastid" "IDB::execFetch($dbh, 'SELECT LAST_INSERT_ID()');" nil 1)
    ("meta" "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">" nil 0)
    ("onsubmit" "onSubmit=\"return confirm('’ËÜ’Åö’¤Ë’ºï’½ü’¤·’¤Þ’¤¹’¤«’¡©')\"" nil 1)
    ("printhtml" "ITK2::printHTML(" $CONFIG{HTML_DIR}/aaa\.html 0)
    ("psid" "$p->{service_id}" nil 25)
    ("sid" "service_id" nil 81)
    ("sps" "service_id => $p->{service_id}" nil 54)
    ("trac" "=== ’£±’¡¥’³µ’Í× ===

=== ’£²’¡¥’ÌÜ’Åª ===

=== ’£³’¡¥’¾Ü’ºÙ ===

=== ’£´’¡¥’Êä’Â­ ===
’ÆÃ’¤Ë’¤Ê’¤·

’°Ê’¾å
" nil 3)
    ))

(define-abbrev-table 'html-mode-abbrev-table '(
    ))

(define-abbrev-table 'idl-mode-abbrev-table '(
    ))

(define-abbrev-table 'java-mode-abbrev-table '(
    ("catch" "catch" c-electric-continued-statement 0)
    ("else" "else" c-electric-continued-statement 0)
    ("finally" "finally" c-electric-continued-statement 0)
    ("while" "while" c-electric-continued-statement 0)
    ))

(define-abbrev-table 'lisp-mode-abbrev-table '(
    ("aut" ["(autoload ' \"\" t t)
" 9 (20 12 14) nil] expand-abbrev-hook 0)
    ("defa" ["(defadvice   (around   act)
  \"\"
  
  )" 28 (39 12 22 32 36) nil] expand-abbrev-hook 0)
    ("defc" ["(defconst   nil
  \"\")
" 12 (22 11 13 20) nil] expand-abbrev-hook 0)
    ("defm" ["(defmacro  ()
  \"\"
  (` 
    ))" 21 (31 11 13 18 25) nil] expand-abbrev-hook 0)
    ("defs" ["(defsubst   ()
  \"\"
  (interactive)
  )" 29 (39 11 14 19 23 39) nil] expand-abbrev-hook 0)
    ("defu" ["(defun   ()
  \"\"
  (interactive)
  (let* (
         )
    
    ))" 58 (65 8 11 16 32 43 59) nil] expand-abbrev-hook 0)
    ("defv" ["(defvar   nil
  \"\")
" 12 (20 9 11 18) nil] expand-abbrev-hook 0)
    ("let" ["(let* (
)
    " 7 (14 8 13) nil] expand-abbrev-hook 0)
    ("sav" ["(save-excursion
 
)" 2 (19 18) nil] expand-abbrev-hook 0)
    ))

(define-abbrev-table 'log-edit-mode-abbrev-table '(
    ))

(define-abbrev-table 'network-connection-mode-abbrev-table '(
    ))

(define-abbrev-table 'nslookup-mode-abbrev-table '(
    ("e" "exit" nil 0)
    ("f" "finger" nil 0)
    ("h" "help" nil 0)
    ("lse" "lserver" nil 0)
    ("q" "exit" nil 0)
    ("r" "root" nil 0)
    ("s" "set" nil 0)
    ("se" "server" nil 0)
    ("v" "viewer" nil 0)
    ))

(define-abbrev-table 'objc-mode-abbrev-table '(
    ("else" "else" c-electric-continued-statement 0)
    ("while" "while" c-electric-continued-statement 0)
    ))

(define-abbrev-table 'occur-mode-abbrev-table '(
    ))

(define-abbrev-table 'pascal-mode-abbrev-table '(
    ))

(define-abbrev-table 'php-mode-abbrev-table '(
    ))

(define-abbrev-table 'pike-mode-abbrev-table '(
    ("else" "else" c-electric-continued-statement 0)
    ("while" "while" c-electric-continued-statement 0)
    ))

(define-abbrev-table 'select-tags-table-mode-abbrev-table '(
    ))

(define-abbrev-table 'sgml-mode-abbrev-table '(
    ))

(define-abbrev-table 'smbclient-mode-abbrev-table '(
    ("q" "quit" nil 0)
    ))

(define-abbrev-table 'sql-mode-abbrev-table '(
    ))

(define-abbrev-table 'svn-log-edit-mode-abbrev-table '(
    ))

(define-abbrev-table 'svn-log-view-mode-abbrev-table '(
    ))

(define-abbrev-table 'text-mode-abbrev-table '(
    ))

(define-abbrev-table 'vc-annotate-mode-abbrev-table '(
    ))

(define-abbrev-table 'vc-dired-mode-abbrev-table '(
    ))

(define-abbrev-table 'vc-log-mode-abbrev-table '(
    ))

(define-abbrev-table 'yahtml-mode-abbrev-table '(
    ))


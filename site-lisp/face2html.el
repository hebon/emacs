;;
;; face2html.el by TAMURA Kent <kent@hauN.org>
;; $Id: face2html.el,v 1.2 2001/09/10 09:03:39 kent Exp $
;;
;; For Emacs-20.x

;; $B"#(B Abstract
;;
;; Emacs $B$N(B $B%P%C%U%!$G$N(B face $B>pJs$rFI$_<h$C$F!"$=$N;zBN(B($BB@;z!&(B
;; $B<PBN(B)$B!&?'$rH?1G$7$?(B HTML $B$r=PNO$9$k%W%m%0%i%`$G$9!#(B
;;
;; $B;d$N$^$o$j$G$O?'$N=P$k(B Emacs $B$O(B Meadow (Emacs-20.2) $B$7$+$J$$(B
;; $B$N$G!"B>$N(B Emacs $B$GF0:n$9$k$+$I$&$+$OCN$j$^$;$s(B :-)


;; $B"#(B $B%$%s%9%H!<%k(B
;;
;; $B$3$N%U%!%$%k(B face2html.el $B$r(B load-path $B$,DL$C$?%G%#%l%/%H%j$K(B
;; $BCV$-!"(B~/.emacs $B$K(B
;;         (autoload 'face2html "face2html" nil t)
;; $B$H=q$-$^$9!#(B
;;
;; $B%P%$%H%3%s%Q%$%k$9$k(B/$B$7$J$$$O$I$&$>$4<+M3$K!#(B


;; $B"#(B $B;HMQ(B
;;
;; $BJ8;z$K?'$,IU$$$F$$$k%P%C%U%!$G!"(BM-x face2html $B$H$7$F$/$@$5$$!#(B
;; $B%U%!%$%k$K=PNO$9$k$+$I$&$+$rJ9$+$l$^$9!#(B
;;
;; $B!|%U%!%$%k$K=PNO$9$k>l9g(B
;; $B%U%!%$%k$K=PNO$9$k>l9g$O$5$i$K%U%!%$%kL>$r5a$a$i$l$^$9!#$=$N(B
;; $B8e!"(BHTML $B2=$7$?7k2L$,%U%!%$%k$K=PNO$5$l$^$9!#(B
;;
;; $B!|%P%C%U%!$K=PNO$9$k>l9g(B
;; *face2html output* $B$H$$$&%P%C%U%!$,$G$-$F!"$=$3$K(B HTML $B2=$7$?(B
;; $B$b$N$,=PNO$5$l$^$9!#=PNO$N%P%C%U%!L>$O8GDj$G$9$N$G!"0JA0$K(B 
;; face2html $B$G=PNO$7$?7k2L$OLdEzL5MQ$K>e=q$-$5$l$^$9!#A0$N7k2L(B
;; $B$r;D$7$?$$$H$-$O(B rename-buffer $B$J$I$GBP=h$7$F$/$@$5$$!#(B
;;
;; $B=PNO$5$l$?%P%C%U%!$G(B write-file (C-x C-w) $B$J$I$G%U%!%$%k$KJ](B
;; $BB8$9$k$3$H$,$G$-$^$9!#(B


;; $B"#(B HTML $B$K4X$9$k$&$s$A$/(B
;;
;; $B$3$N%W%m%0%i%`$G$O!"(B
;;   $B!&(BPRE $B$G0O$`$+$I$&$+(B
;;   $B!&(BI B FONT SPAN $B$G=$>~$9$k$+!"(BSPAN $B$N$_$G=$>~$9$k$+(B
;; $B$H$$$&A*Br;h$,$"$j$^$9!#(B
;;
;; HTML 4.0 strict $B$G$O!"$=$b$=$b(B FONT $B$H$$$&MWAG$,$"$j$^$;$s!#(B
;; $B$h$C$F!"(BHTML 4.0 strict $B$K=`5r$7$?(B HTML $B$r=PNO$5$;$?$$>l9g$O!"(B
;; (setq face2html-css1 t) $B$H$7$^$9!#$G!"(BHTML 4.0 loose $B$G$O!"(B
;; PRE $BMWAG$NCf$K(B FONT $BMWAG$r4^$a$F$O$$$1$^$;$s!#$3$N%W%m%0%i%`(B
;; $B$N%G%U%)%k%H@_Dj$@$H!"(BPRE $B$NCf$K(B FONT $B$,F~$j$^$9(B($B6l>P(B)$B!#$^!"(B
;; $B$$$:$l$K$7$F$b<B32$O$J$$$s$G$7$g$&$1$I!D!#(B

;; $B"#(B Changes
;;
;; 19980908 The first release
;;
;; 20010910 Toru TSUNEYOSHI $B$5$s$K$h$kJQ99(B
;;          $B!&%j%9%H$J(B face $B$KBP1~(B
;;          $B!&%U%!%$%k$K=q$-9~$`$+!"%P%C%U%!$K=P$9$+$rA*Br$9$k(B
;;          $B!&;vA0$K%P%C%U%!A4BN$r3N<B$K%U%)%s%H%m%C%/$5$;$k(B
;;          $B!&(Btab-width $B$,(B 8 $B0J30$N$H$-$K(B untabify $B$9$k(B


(defconst face2html-buffer-name "*face2html output*")

(defvar face2html-css1 nil
  "B I FONT $BMWAG$r;H$o$:$K!"(B<SPAN style=\"...\"> $B$N$_$G%^!<%/IU$1$r9T$J$&!#(B")

(defvar face2html-insert-pre t
  "$B=PNO$r(B PRE $B%?%0$G0O$`!#(B")

(defvar face2html-tab-switch nil)

(defun face2html (&optional filename)
  "$B8=:_$N%P%C%U%!$N(B face $B>pJs$r(B HTML $B2=$9$k!#(B"
  (interactive)
  (if (null filename)
      (if (y-or-n-p "file(y) or buffer(n) ? ")
	  (setq filename
		(read-file-name
		 (format "Write file (%s.html): "
			 (file-name-nondirectory (buffer-file-name)))
		 default-directory
		 (concat (buffer-file-name) ".html")))
	(message "")))
  (let ((outbuf (if (null filename) (get-buffer-create face2html-buffer-name)
		  (get-buffer-create (buffer-file-name))))
	(face nil)
	thisface
	(target-buffer (current-buffer))
	(face-start (point-min)))
    (save-excursion
      (set-buffer outbuf)
      (erase-buffer)
      (and face2html-insert-pre (insert "<PRE>\n"))
      (set-buffer target-buffer)
      (if (null filename)
	  (display-buffer outbuf))
      (goto-char (point-min))
      (let ((font-lock-maximum-size (point-max)))
	     (font-lock-fontify-buffer)) ; $B%P%C%U%!A4$F$N%U%)%s%H%m%C%/(B
      (if (not (eq tab-width 8))	; $B%?%V$NI}(B != 8 $B$N>l9g(B
	  (let ((untab-width tab-width) ; $B%?!<%2%C%H%P%C%U%!$N%?%VI}(B $B<hF@(B
		(untab-buf "*face2html output for untabify*")
					; untabify $BMQ%P%C%U%!L>(B
		)
	    (get-buffer-create untab-buf)
	    (copy-to-buffer untab-buf (point-min) (point-max))
	    (set-buffer untab-buf)
	    (set-variable 'tab-width untab-width)
	    (untabify (point-min) (point-max))
;	     (set-variable 'tab-width 8)
;	     (tabify (point-min) (point-max))
	    (setq target-buffer (current-buffer))))

      (while (< (point) (point-max))
	(setq thisface (get-text-property (point) 'face))
	(cond ((equal thisface face) nil)
	      ((null face)
	       (face2html-copy outbuf face-start (point))
	       (setq face-start (point)))
	      (t
	       (face2html-create-html outbuf face-start (point) face)
	       (setq face-start (point))))
	(setq face thisface)
	(forward-char 1))
      (if thisface (face2html-create-html outbuf face-start (point-max) thisface)
	(face2html-copy outbuf face-start (point-max)))

      (if face2html-insert-pre
	  (progn
	    (set-buffer outbuf)
	    (insert "</PRE>\n")
	    (set-buffer target-buffer)))

      (if (not (eq tab-width 8))
	   (kill-buffer target-buffer))

      (if filename
	   (progn (set-buffer outbuf)
		  (write-file filename)
		  (kill-buffer outbuf)))
      )))

(defun face2html-create-color-string (cname)
  "$B?'$NL>A0$+$i!"(BHTML $B$G;HMQ$9$k(B #rrggbb $B$H$$$&J8;zNs$r:n@.$9$k!#(B"
  (let ((colorval (x-color-values cname)))
    (format "#%2.2x%2.2x%2.2x"
	    (/ (nth 0 colorval) 256)
	    (/ (nth 1 colorval) 256)
	    (/ (nth 2 colorval) 256))))


(defun face2html-create-html (outbuf start end face)
  "$B8=9T%P%C%U%!$N(B start $B$+$i(B end $B$^$G$r(B outbuf $B$N%]%$%s%H$KA^F~$9$k!#(B
face $B$K=>$C$F(B HTML $B$N%?%0$rA^F~$9$k!#(B"
  (let ((target-buffer (current-buffer))
	 (boldp (if (listp face)	; face $B%W%m%Q%F%#$,%j%9%H$N>l9g(B
		    (let ((face_list face)
			  prop)
		      (catch 'loop
			(while (car face_list)
			  (setq prop (face-bold-p (car face_list)))
			  (if prop
			      (throw 'loop t))
			  (setq face_list (cdr face_list)))))
		  (face-bold-p face)))
	 (italicp (if (listp face)
		      (let ((face_list face)
			    prop)
			(catch 'loop
			  (while (car face_list)
			    (setq prop (face-italic-p (car face_list)))
			    (if prop
				(throw 'loop t))
			    (setq face_list (cdr face_list)))))
		    (face-italic-p face)))
	 (fcolor (if (listp face)
		    (let ((face_list face)
			  prop)
		      (catch 'loop
			(while (car face_list)
			  (setq prop (face-foreground (car face_list)))
			  (if prop
			      (throw 'loop prop))
			  (setq face_list (cdr face_list)))))
		  (face-foreground face)))
	 (bcolor (if (listp face)
		    (let ((face_list face)
			  prop)
		      (catch 'loop
			(while (car face_list)
			  (setq prop (face-background (car face_list)))
			  (if prop
			      (throw 'loop prop))
			  (setq face_list (cdr face_list)))))
		  (face-background face)))
	colorval
	replace-start replace-end)
    (set-buffer outbuf)

    (if face2html-css1
	(progn
	  (insert "<SPAN style=\"")
	  (if boldp (insert "font-weight:bold;"))
	  (if italicp (insert "font-style:italic;"))
	  (if fcolor (insert (concat "color:"
				     (face2html-create-color-string fcolor) ";")))
	  (if bcolor (insert (concat "background-color:"
				     (face2html-create-color-string bcolor) ";")))
	  (insert "\">"))
      (progn
	(if boldp (insert "<B>"))
	(if italicp (insert "<I>"))
	(if fcolor (progn
		     (setq colorval (x-color-values fcolor))
		     (insert (concat "<FONT color=\""
				     (face2html-create-color-string fcolor)
				     "\">"))))
	(if bcolor (insert (concat "<SPAN style=\"background-color:"
				   (face2html-create-color-string bcolor)
				   ";\">")))))
    (setq replace-start (point))
    (insert-buffer-substring target-buffer start end)
    (face2html-to-entity-reference replace-start)
    (if face2html-css1
	(insert "</SPAN>")
      (progn
	(if bcolor (insert "</SPAN>"))
	(if fcolor (insert "</FONT>"))
	(if italicp (insert "</I>"))
	(if boldp (insert "</B>"))))

    (set-buffer target-buffer)
    ))

(defun face2html-copy (outbuf start end)
  "$B8=9T%P%C%U%!$N(B start $B$+$i(B end $B$^$G$r(B outbuf $B$N%]%$%s%H$KA^F~$9$k!#(B"
  (let ((target-buffer (current-buffer)) replace-start)
    (set-buffer outbuf)
    (setq replace-start (point))
    (insert-buffer-substring target-buffer start end)
    (face2html-to-entity-reference replace-start)
    (set-buffer target-buffer)))

(defun face2html-to-entity-reference (replace-start)
  "replace-start $B$+$i(B (point-max) $B$^$G$N(B <>& $B$r$=$l$>$l(B &lt; &gt; &amp; $B$KCV49$9$k!#(B"
  (save-excursion
    (goto-char replace-start)
    (while (re-search-forward "[<>&]" (point-max) t)
      (let (tl)
	(setq tl (buffer-substring (match-beginning 0) (match-end 0)))
	(cond ((string= tl "<") (replace-match "&lt;"))
	      ((string= tl ">") (replace-match "&gt;"))
	      ((string= tl "&") (replace-match "&amp;")))))))

(provide 'face2html)

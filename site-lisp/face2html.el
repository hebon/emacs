;;
;; face2html.el by TAMURA Kent <kent@hauN.org>
;; $Id: face2html.el,v 1.2 2001/09/10 09:03:39 kent Exp $
;;
;; For Emacs-20.x

;; ■ Abstract
;;
;; Emacs の バッファでの face 情報を読み取って、その字体(太字・
;; 斜体)・色を反映した HTML を出力するプログラムです。
;;
;; 私のまわりでは色の出る Emacs は Meadow (Emacs-20.2) しかない
;; ので、他の Emacs で動作するかどうかは知りません :-)


;; ■ インストール
;;
;; このファイル face2html.el を load-path が通ったディレクトリに
;; 置き、~/.emacs に
;;         (autoload 'face2html "face2html" nil t)
;; と書きます。
;;
;; バイトコンパイルする/しないはどうぞご自由に。


;; ■ 使用
;;
;; 文字に色が付いているバッファで、M-x face2html としてください。
;; ファイルに出力するかどうかを聞かれます。
;;
;; ●ファイルに出力する場合
;; ファイルに出力する場合はさらにファイル名を求められます。その
;; 後、HTML 化した結果がファイルに出力されます。
;;
;; ●バッファに出力する場合
;; *face2html output* というバッファができて、そこに HTML 化した
;; ものが出力されます。出力のバッファ名は固定ですので、以前に 
;; face2html で出力した結果は問答無用に上書きされます。前の結果
;; を残したいときは rename-buffer などで対処してください。
;;
;; 出力されたバッファで write-file (C-x C-w) などでファイルに保
;; 存することができます。


;; ■ HTML に関するうんちく
;;
;; このプログラムでは、
;;   ・PRE で囲むかどうか
;;   ・I B FONT SPAN で修飾するか、SPAN のみで修飾するか
;; という選択肢があります。
;;
;; HTML 4.0 strict では、そもそも FONT という要素がありません。
;; よって、HTML 4.0 strict に準拠した HTML を出力させたい場合は、
;; (setq face2html-css1 t) とします。で、HTML 4.0 loose では、
;; PRE 要素の中に FONT 要素を含めてはいけません。このプログラム
;; のデフォルト設定だと、PRE の中に FONT が入ります(苦笑)。ま、
;; いずれにしても実害はないんでしょうけど…。

;; ■ Changes
;;
;; 19980908 The first release
;;
;; 20010910 Toru TSUNEYOSHI さんによる変更
;;          ・リストな face に対応
;;          ・ファイルに書き込むか、バッファに出すかを選択する
;;          ・事前にバッファ全体を確実にフォントロックさせる
;;          ・tab-width が 8 以外のときに untabify する


(defconst face2html-buffer-name "*face2html output*")

(defvar face2html-css1 nil
  "B I FONT 要素を使わずに、<SPAN style=\"...\"> のみでマーク付けを行なう。")

(defvar face2html-insert-pre t
  "出力を PRE タグで囲む。")

(defvar face2html-tab-switch nil)

(defun face2html (&optional filename)
  "現在のバッファの face 情報を HTML 化する。"
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
	     (font-lock-fontify-buffer)) ; バッファ全てのフォントロック
      (if (not (eq tab-width 8))	; タブの幅 != 8 の場合
	  (let ((untab-width tab-width) ; ターゲットバッファのタブ幅 取得
		(untab-buf "*face2html output for untabify*")
					; untabify 用バッファ名
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
  "色の名前から、HTML で使用する #rrggbb という文字列を作成する。"
  (let ((colorval (x-color-values cname)))
    (format "#%2.2x%2.2x%2.2x"
	    (/ (nth 0 colorval) 256)
	    (/ (nth 1 colorval) 256)
	    (/ (nth 2 colorval) 256))))


(defun face2html-create-html (outbuf start end face)
  "現行バッファの start から end までを outbuf のポイントに挿入する。
face に従って HTML のタグを挿入する。"
  (let ((target-buffer (current-buffer))
	 (boldp (if (listp face)	; face プロパティがリストの場合
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
  "現行バッファの start から end までを outbuf のポイントに挿入する。"
  (let ((target-buffer (current-buffer)) replace-start)
    (set-buffer outbuf)
    (setq replace-start (point))
    (insert-buffer-substring target-buffer start end)
    (face2html-to-entity-reference replace-start)
    (set-buffer target-buffer)))

(defun face2html-to-entity-reference (replace-start)
  "replace-start から (point-max) までの <>& をそれぞれ &lt; &gt; &amp; に置換する。"
  (save-excursion
    (goto-char replace-start)
    (while (re-search-forward "[<>&]" (point-max) t)
      (let (tl)
	(setq tl (buffer-substring (match-beginning 0) (match-end 0)))
	(cond ((string= tl "<") (replace-match "&lt;"))
	      ((string= tl ">") (replace-match "&gt;"))
	      ((string= tl "&") (replace-match "&amp;")))))))

(provide 'face2html)

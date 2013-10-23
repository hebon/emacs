
;;手動でsite-lispに配置

skk
cp5022x
face2html
ffap-perl-module
fswiki-mode
minibuf-isearch
moccur-edit
smarttabs
srep
yaml-mode
yasnippet-config

;;自作などsite-lispに配置
add-change-log-entry2
html-mode-hook
yahtml-utf.patch

;;設定など
~/.emacs
~/.emacs.d/snippets
~/.emacs.d/.abbrev_defs

~/.emacs-places
~/.recentf
~/.session
~/_yatexrc

;;package使用
(package-install 'color-moccur)
(package-install 'cperl-mode)
(package-install 'dropdown-list)
(package-install 'markdown-mode)
(package-install 'php-mode)
(package-install 'session)
(package-install 'textile-mode)
(package-install 'w3m)
(package-install 'web-mode)
(package-install 'yasnippet)
(package-install 'zencoding-mode)

--------------------------------------------------------------------------------
SKKのインストール

APELが必要らしいのでダウンロード。
http://kanji.zinbun.kyoto-u.ac.jp/~tomo/elisp/APEL/index.html.ja より apel-10.8.tar.gz
make があれば普通に make install でいいんですが、Windows 環境で make 入れてない場合は makeit.bat を使うらしい。
makeit.bat を開いて下のように編集。
 set PREFIX=C:\emacs
set EMACS=%PREFIX%\bin\emacs.exe
set LISPDIR=%PREFIX%\site-lisp
コンパイルしてインストール。（日本語の含まれてないパスでやったほうがいいかも）
 > makeit.bat elc
> makeit.bat install
続いて SKK をダウンロード。
http://openlab.ring.gr.jp/skk/main-ja.html より、ddskk-14.0.91.tar.gz
辞書（SKK-JISYO.L）もついでに。
http://openlab.ring.gr.jp/skk/wiki/wiki.cgi?page=SKK%BC%AD%BD%F1
解凍して、ddskk/dic/ に SKK-JISYO.L を置いておく。
APELと同様に makeit.bat を編集、コンパイルしてインストール。

--------------------------------------------------------------------------------
skk	日本語入力	GPL	http://openlab.jp/skk/skk/main/READMEs/README
yahtml	HTML用メジャーモード	Restrictive/Distributable	http://pdb.finkproject.org/pdb/package.php/yatex
php-mode	PHP用メジャーモード	GPL	http://sourceforge.net/projects/php-mode/
moinmoin-mode	TracのWiki用メジャーモード	GPL	http://moinmo.in/EmacsForMoinMoin/MoinMoinMode?action=raw
anything	統合インターフェース	GPL	http://www.emacswiki.org/cgi-bin/emacs/Anything
yasnippet	補完	GPL	http://code.google.com/p/yasnippet/
zencoding-mode	HTML入力補助	GPL	http://www.emacswiki.org/emacs/ZenCoding
color-moccur.el	検索補助	GPL	http://www.bookshelf.jp/elc/color-moccur.el
moccur-edit.el	検索補助	GPL	http://www.bookshelf.jp/elc/moccur-edit.el
wdired.el	ファイル操作	GPL	http://groups.google.com/groups?as_ugroup=gnu.emacs.sources&as_q=wdired
session.el	履歴管理	GPL	http://emacs-session.sourceforge.net/
minibuf-isearch	履歴検索	GPL	http://www.sodan.org/~knagano/emacs/minibuf-isearch/minibuf-isearch.el
SmartTabs	空白入力最適化	GPL	http://www.emacswiki.org/emacs/SmartTabs
whitespace http://www.emacswiki.org/emacs/download/whitespace.el
ffap-perl-module	ファイルを開く補助	GPL	http://user42.tuxfamily.org/ffap-perl-module/index.html
srep	連番入力	GPL	https://github.com/kmorimoto/srep/blob/master/srep.el


--------------------------------------------------------------------------------
;; OLD

(install-elisp-from-emacswiki "color-moccur.el")
(install-elisp-from-emacswiki "moccur-edit.el")
(install-elisp-from-emacswiki "wdired.el")
(install-elisp-from-emacswiki "session.el")
;(install-elisp-from-emacswiki "minibuf-isearch.el")
(install-elisp "http://www.sodan.org/~knagano/emacs/minibuf-isearch/minibuf-isearch.el")

(auto-install-batch "anything")

; SmartTabs http://gist.github.com/188961
(install-elisp-from-gist "188961")

;(install-elisp-from-emacswiki "whitespace")
(install-elisp "http://www.emacswiki.org/emacs/download/whitespace.el")


--------------------------------------------------------------------------------
;; OLD

;;~/emacs-settings/

dropdown-list
smarttabs
yasnippet
yasnippet-config

.abbrev_defs
.template

add-change-log-entry2
html-mode-hook

;;~/.emacs.d/

tramp
snippet/

;;~/.emacs.d/auto-install/

color-moccur
minibuf-isearch
moccur-edit
session
smarttabs

;;~/.emacs.d/elpa/
all
archives
color-moccur
cperl-mode
markdown-mode
session
textile-mode
w3m
web-mode
yahtml-mode

;;~/bin/emacs/site-lisp/
apel/
emu/
foreign-regexp/
skk/
yatex/
add-change-log-entry2
auto-install
coupling
cp5022x
face2html
ffap-perl-module
fswiki-mode
moccur-edit
moinmoin-mode
moinmoin-mode.patch
php-mode
screen-lines
search-web
srep
subdirs
yahtml-utf.patch
yaml-mode
zencoding-mode

;;others

wdired
whitespace

(cond
 ((= emacs-major-version 21)(load "01_emacs21.el"))
 ((= emacs-major-version 22)(load "01_emacs22.el"))
 ((= emacs-major-version 23)
  (progn
    (load "01_emacs23.el")
    (load "10_emacs23_major_mode.el")
    (load "90_emacs23_my_func.el")
    (load "99_emacs23_tmp.el")
    ))
 ((= emacs-major-version 24)
   (progn
     (load "01_emacs24.el")
     (load "10_emacs24_major_mode.el")
     (load "90_emacs24_my_func.el")
     (load "99_emacs24_tmp.el")
    ))
 )

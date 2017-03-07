;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; load config files in .emacs.d/config
(load "~/.emacs.d/scripts/load-directory.el")
; (load "~/.emacs.d/scripts/prelude-packages.el")  ;; doesn't work!!
(load-directory "~/.emacs.d/config")

;;;;;;;;;;
;; themes
;;;;;;;;;;
;;;
;; solarized - https://github.com/sellout/emacs-color-theme-solarized
;; (add-to-list 'custom-theme-load-path "/home/doctor/.emacs.d/themes/solarized")
;; (load-theme 'solarized t)
;; (set-frame-parameter nil 'background-mode 'dark)
;; (enable-theme 'solarized)

;;  atom's one-dark - https://github.com/whitlockjc/atom-dark-theme-emacs
(load-theme 'atom-dark t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (atom-dark-theme atom-one-dark-theme pdf-tools evil-surround))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

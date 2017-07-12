;;; appearance.el -- Here goes all the style
;;;;;;;;;;
;; Appearance
;;;;;;;;;;

;;; Commentary:

;;; Code:
;; Set font
;(add-to-list 'default-frame-alist '(font . "Hack-10" ))
;(setq default-frame-alist '((font . "Inconsolata for Powerline Nerd Font Complete Medium-10")))
;(set-frame-font "Inconsolata For Powerline Nerd Font Complete Mono-10")
;(set-face-attribute 'default nil :family "Inconsolata for Powerline Nerd Font Complete Mono" :height 100 :weight 'normal)
;(set-face-attribute 'default nil :family "InconsolataForPowerline Nerd Font Complete Medium" :height 100 :weight 'normal)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "InconsolataForPowerline Nerd Font" :foundry "PfEd" :slant normal :weight normal :height 102 :width normal)))))

;; Mute Emacs
(setq ring-bell-function 'ignore)

(if (display-graphic-p)
    (progn
      ;; Disable Toolbar
      (tool-bar-mode 0)
      ;; Disable scrollbar
      (scroll-bar-mode 0)))

;; Disable cursor blink
(blink-cursor-mode 0)

;; Highlight current line
(global-hl-line-mode t)

;; Show matching brackets
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Shameless extraction of Spacemacs' startup screen
(use-package dashboard
  :init
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
                          (bookmarks . 5)
                          (projects . 5)))
  (setq dashboard-banner-logo-title "Welcome Tobi, madmacs is now ready for you.")
  (setq dashboard-startup-banner madmacs/dash-banner))


;; Introducing Icons to Emacs
;; all-the-icons-dired needs Tramp loaded
(require 'tramp)
(use-package all-the-icons
  :ensure t
  :config
  (use-package all-the-icons-dired
    :ensure t
    :init (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)))

;(use-package powerline
;  :ensure t)
;(use-package smart-mode-line :after powerline
;  :ensure t
;  :config
;  (setq sml/theme 'automatic)
;  (setq sml/no-confirm-load-theme t)
;  (sml/setup))

;; Requirement of Spaceline
(use-package powerline
  :ensure t)
(use-package spaceline :after powerline
  :ensure t
  :config

  (use-package spaceline-config
    :ensure spaceline
    :config

    (spaceline-helm-mode)
    (spaceline-toggle-workspace-number-on)
    (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)

    (use-package spaceline-all-the-icons
      :load-path "settings/spaceline"
      :config
        (use-package spaceline-colors
          :load-path "settings/spaceline"
          :init (add-hook 'after-init-hook 'spaceline-update-faces)
          :config (advice-add 'load-theme :after 'spaceline-update-faces))

        (setq-default powerline-default-separator 'nil)
        (setq-default mode-line-format '("%e" (:eval (spaceline-ml-ati))))
      )
    (spaceline-compile)))

;(use-package mode-icons
;  :ensure t
;  :config
;  (setq mode-icons-line-height-adjust 10)
;  (mode-icons-mode))


;;;
;;  atom's one-dark - https://github.com/whitlockjc/atom-dark-theme-emacs
;; (load-theme 'atom-dark)
(load-theme 'spacemacs-dark t)

;;;;;;;;;;;
;;; Code Appearance
;;;;;;;;;;;

(use-package emojify
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-emojify-mode))

;; Highlight matching delimiters
(use-package rainbow-delimiters
  :ensure t
  :diminish rainbow-delimiters-mode
  :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; Show colors in code
(use-package rainbow-mode
  :ensure t
  :diminish (rainbow-mode . "")
  :init
  (dolist
      (hook '(css-mode-hook
              html-mode-hook
              js-mode-hook
              emacs-lisp-mode-hook
              text-mode-hook))
    (add-hook hook #'rainbow-mode)))

;; Show git modifications
(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :init (global-git-gutter-mode +1)
  :config
  ;; hide if there are no changes
  (validate-setq git-gutter:hide-gutter t)

  (use-package git-gutter-fringe
    :ensure t
    :config
    ;; colored fringe "bars"
    (define-fringe-bitmap 'git-gutter-fr:added
      [224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224]
      nil nil 'center)
    (define-fringe-bitmap 'git-gutter-fr:modified
      [224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224]
      nil nil 'center)
    (define-fringe-bitmap 'git-gutter-fr:deleted
      [0 0 0 0 0 0 0 0 0 0 0 0 0 128 192 224 240 248]
      nil nil 'center))

  ;; Refreshing git-gutter
  (advice-add 'evil-force-normal-state :after 'git-gutter)
  (add-hook 'focus-in-hook 'git-gutter:update-all-windows))

(provide 'appearance)
;;; appearance.el ends here

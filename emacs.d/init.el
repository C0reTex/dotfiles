;; init.el --- Emacs config madmacs by c0retex

;;  _______  _______  ______   _______  _______  _______  _______
;; (       )(  ___  )(  __  \ (       )(  ___  )(  ____ \(  ____ \
;; | () () || (   ) || (  \  )| () () || (   ) || (    \/| (    \/
;; | || || || (___) || |   ) || || || || (___) || |      | (_____
;; | |(_)| ||  ___  || |   | || |(_)| ||  ___  || |      (_____  )
;; | |   | || (   ) || |   ) || |   | || (   ) || |            ) |
;; | )   ( || )   ( || (__/  )| )   ( || )   ( || (____/\/\____) |
;; |/     \||/     \|(______/ |/     \||/     \|(_______/\_______)
;;

;;; Commentary:
;; A huge thank you goes out to http:/github.com/onc and his awesome Emacs config.
;; He gave me a comprehensiv jump start into the world of Emacs.
;;
;; The config is divided in the following sections:
;;  * Constants          - all (defconst.. goes here
;;  * Keybindings        - as the name implies
;;  * Package management - introducing use-package to stop package managening beeing a pain in the neck.
;;  * Appearance         - Eye candy
;;  * File handling      - file related stuff. UTF-8 encoding and the same.
;;  * Code appearance    - icons, emojis,... the beautiful things in life.
;;  * Usability          - the place for packages to make life easier

;;;;;;;;;;
;; Constants and load-path
;;;;;;;;;;
;;; Code:
(defconst madmacs/dash-banner (expand-file-name "~/.emacs.d/themes/madmax.png"))
(defconst madmacs/settings-dir (expand-file-name "~/.emacs.d/settings"))
(add-to-list 'load-path madmacs/settings-dir)
;(add-to-list 'flycheck-emacs-lisp-load-path settings-dir)

;;;;;;;;;;
;; package management
;;;;;;;;;;

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package
;; from https://github.com/jwiegley/use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

; Validation of setq and stuff
(use-package validate
  :ensure t)

;; Simple library for asynchronous processing
(use-package async
  :ensure t
  :defer t
  :config
  (require 'async-bytecomp))

;;;;;;;;;;
;; Key bindings
;;;;;;;;;;
(require 'keybindings)

;;;;;;;;;;
;; Appearance
;;;;;;;;;;
(require 'appearance)

;;;;;;;;;;
;; File handling
;;;;;;;;;;

;; Make sure UTF-8 is used
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")

;; Make emacs use spaces instead of tabs
(setq-default tab-width 2 indent-tabs-mode nil)

;; Disable double spaces at the end of a sentence
(setq-default sentence-end-double-space nil)

;; Don't go in for the kill.
(setq confirm-kill-emacs 'y-or-n-p)

;; Don't make me type 'yes' or 'no', y/n will do
(defalias 'yes-or-no-p 'y-or-n-p)

;; Check (on save) whether the file edited contains a shebang, if yes, make it executable
;; from http://mbork.pl/2015-01-10_A_few_random_Emacs_tips
(add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)

;; Highlight some keywords in prog-mode
(defun madmacs/watch-words ()
  (interactive)
  (font-lock-add-keywords
   nil '(("\\<\\(FIXME\\|TODO\\|BUG\\|DONE\\)" 1 font-lock-warning-face t))))
(add-hook 'prog-mode-hook 'madmacs/watch-words)
(add-hook 'LaTeX-mode-hook 'madmacs/watch-words)

;; Delete trailing whitespaces
(defun madmacs/exterminate_trailing ()
  (add-hook 'write-file-hooks 'delete-trailing-whitespace)
  (add-hook 'before-save-hooks 'whitespace-cleanup))

(add-hook 'prog-mode-hook 'madmacs/exterminate_trailing)

;; Set browser for urls
(validate-setq browse-url-browser-function 'browse-url-chromium)

;; Document support (.pdf , .doc, .ps,...)
(use-package doc-view
  :ensure t
  :bind (:map doc-view-mode-map
              ("j" . doc-view-next-page)
              ("<SPC>" . doc-view-next-page)
              ("k" . doc-view-previous-page))
  :init (add-hook 'doc-view-mode-hook #'doc-view-fit-page-to-window))

;; Projects in emacs
(use-package projectile
  :ensure t
  :init (projectile-mode t))

;; Git support for emacs
(use-package magit
  :load-path "git-packages/magit/lisp"
  :commands (magit-status magit-log-all)
  :config
  (validate-setq magit-diff-refine-hunk t)
  (with-eval-after-load 'info
    (info-initialize)
    (add-to-list 'Info-directory-list "~/.emacs.d/git-packages/magit/Documentation"))

  (use-package magit-gitflow
    :load-path "git-packages/magit-gitflow"
    :init
    (add-hook 'magit-mode-hook #'turn-on-magit-gitflow)))

;;;;;;;;;;
;; Usability
;;;;;;;;;;

(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode 1))

;; save window configuration
(when (fboundp 'winner-mode)
  (global-set-key (kbd "C-c h") 'winner-undo)
  (global-set-key (kbd "C-c l") 'winner-redo)
  (winner-mode 1))

;; when typing a left bracke automatically insert the right one.
(use-package elec-pair
  :init (electric-pair-mode t))

;; introduce dictcc to emacs
(use-package dictcc
  :ensure t
  :config
  (validate-setq dictcc-source-lang "de"
                 dictcc-destination-lang "en"))

(use-package helm
  :diminish helm-mode
  :bind (("C-h C-h" . helm-apropos)
         ("M-x"     . helm-M-x)
         ("C-x b"   . helm-mini)
         ("C-x C-f" . helm-find-files)
         :map helm-map
         ("<tab>" . helm-execute-persistent-action)
         ("C-i" . helm-execute-persistent-action)
         ("C-j" . helm-select-action)
         ("M-j" . helm-next-line)
         ("M-k" . helm-previous-line)
         ("C-c z" . helm-perspeen))
  :config
  (require 'helm-config)
  (use-package helm-perspeen)

  (setq helm-mini-default-sources
        '(helm-source-perspeen-tabs
          helm-source-buffers-list
          helm-source-perspeen-workspaces
          helm-source-projectile-projects
          helm-source-recentf
          helm-source-buffer-not-found))
  (helm-mode +1)

  ;; Fuzzy matching
  (validate-setq helm-mode-fuzzy-match t)
  (validate-setq helm-completion-in-region-fuzzy-match t)

  (validate-setq helm-ff-file-name-history-use-recentf t)

  (validate-setq helm-reuse-last-window-split-state t)
  ;; Don't use full width of the frame
  (validate-setq helm-split-window-in-side-p t)
  (helm-autoresize-mode t)

  ;; Use ack instead of grep
  (when (executable-find "ack")
    (validate-setq helm-grep-default-command "ack -Hn --no-group --no-color %p %f"
                   helm-grep-default-recurse-command "ack -H --no-group --no-color %p %f"))

  ;; Even better, use ag if it's available
  (when (executable-find "ag")
    (validate-setq helm-grep-default-command "ag --vimgrep -z %p %f"
                   helm-grep-default-recurse-command "ag --vimgrep -z %p %f"))

  (use-package helm-ag
    :ensure t)

  (use-package helm-dash
    :ensure t
    :preface
    (defun rust-doc ()
      (interactive)
      (setq-local helm-dash-docsets '("Rust")))

    (defun cc-doc ()
      (interactive)
      (setq-local helm-dash-docsets '("C\+\+")))
    :init
    (add-hook 'rust-mode-hook 'rust-doc)
    (add-hook 'c++-mode-hook 'cc-doc)
    :config
    (validate-setq helm-dash-browser-func 'eww))

  (use-package helm-swoop
    :ensure t
    :bind (("M-i" . helm-swoop)
           ("M-I" . helm-multi-swoop-projectile)))

  (use-package helm-projectile
    :ensure t
    :init (helm-projectile-on)
    :config
    (validate-setq projectile-completion-system 'helm)))

;; Better emacs package menu
(use-package paradox
  :commands (paradox-list-packages)
  :config
  (validate-setq paradox-automatically-star nil
                 paradox-display-star-count nil
                 paradox-execute-asynchronously t))

;; Add a terminal to Emacs
(use-package multi-term
  :ensure t
  :config
  (setq multi-term-program "/bin/zsh"))

;; Save position in files
(use-package saveplace
  :init(save-place-mode t)
  :config (validate-setq save-place-file (expand-file-name "places" user-emacs-directory)))

;; Edit files as root, through Tramp
(use-package sudo-edit
  :ensure t
  :bind (("C-c f s" . sudo-edit)))

;; Check syntax on the fly
;; currently installed syntax checkers:
;; pylint, eslint, csslint, jsonlint, markdownlint(mdl), rubocop, js-yaml, texinfo
(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :init (global-flycheck-mode t))

;; Evil is love, Evil is live
(use-package undo-tree
  :after evil
  :diminish "\uF0E2")
(use-package evil
  :ensure t
  :bind (:map evil-normal-state-map
              ("Y" . copy-to-end-of-line)
              ("j" . evil-next-visual-line)
              ("k" . evil-previous-visual-line)
              ("gj" . evil-next-line)
              ("gk" . evil-previous-line))
  :init
  (evil-mode t)
  (defun add-vim-bindings()
    (define-key evil-normal-state-local-map (kbd "<escape>") 'save-with-escape-and-timeout))
  ;; provided by onc
  (defun set-control-w-shortcuts ()
    (define-prefix-command 'madmacs-window-map)
    (global-set-key (kbd "C-w") 'madmacs-window-map)
    (define-key madmacs-window-map (kbd "h") 'evil-window-left)
    (define-key madmacs-window-map (kbd "j") 'evil-window-down)
    (define-key madmacs-window-map (kbd "k") 'evil-window-up)
    (define-key madmacs-window-map (kbd "l") 'evil-window-right)
    (define-key madmacs-window-map (kbd "H") 'evil-window-move-far-left)
    (define-key madmacs-window-map (kbd "J") 'evil-window-move-far-down)
    (define-key madmacs-window-map (kbd "K") 'evil-window-move-far-up)
    (define-key madmacs-window-map (kbd "L") 'evil-window-move-far-right)
    (define-key madmacs-window-map (kbd "_") 'split-window-right)
    (define-key madmacs-window-map (kbd "-") 'split-window-below)
    (define-key madmacs-window-map (kbd "fo") 'find-file-other-window)
    (define-key madmacs-window-map (kbd "x") 'delete-window)
    (define-key madmacs-window-map (kbd "o") 'delete-other-windows)
    (define-key madmacs-window-map (kbd "c") 'perspeen-create-ws)
    (define-key madmacs-window-map (kbd "n") 'perspeen-next-ws)
    (define-key madmacs-window-map (kbd "p") 'perspeen-previous-ws)
    (define-key madmacs-window-map (kbd "C-w") 'perspeen-goto-last-ws)
    (define-key madmacs-window-map (kbd "r") 'perspeen-rename-ws)
    (define-key madmacs-window-map (kbd "d") 'perspeen-delete-ws)
    (define-key madmacs-window-map (kbd "t") 'perspeen-tab-create-tab)
    (define-key madmacs-window-map (kbd "T") 'perspeen-tab-del)
    (define-key madmacs-window-map (kbd "[") 'perspeen-tab-prev)
    (define-key madmacs-window-map (kbd "]") 'perspeen-tab-next))
  :config
  (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
; from: https://lists.ourproject.org/pipermail/implementations-list/2014-September/002064.html
  (eval-after-load "evil-maps"
    '(dolist (map (list evil-motion-state-map
                        evil-insert-state-map
                        evil-emacs-state-map))
       (define-key map "\C-w" nil)
       (set-control-w-shortcuts)
       (define-key map "\C-u" nil)
       (global-set-key (kbd "C-u") 'evil-scroll-up)))
  (define-key evil-ex-map "q" 'kill-buffer)

  ;; Disable Evil in the following modes
  (evil-set-initial-state 'paradox-menu-mode 'emacs)
  (evil-set-initial-state 'el-get-package-menu-mode 'emacs)
  (evil-set-initial-state 'ag-mode 'emacs)
  ;; (evil-set-initial-state 'flycheck-error-list-mode 'emacs)
  ;; (evil-set-initial-state 'dired-mode 'emacs)
  (evil-set-initial-state 'neotree-mode 'emacs)
  (evil-set-initial-state 'magit-popup-mode 'emacs)
  (evil-set-initial-state 'magit-mode 'emacs)
  (evil-set-initial-state 'pdf-view-mode 'emacs)
  (evil-set-initial-state 'pdf-annot-list-mode 'emacs)
  (evil-set-initial-state 'calendar-mode 'emacs)

  (use-package evil-leader
    :ensure t
    :init (global-evil-leader-mode)
    :config
    (evil-leader/set-key
      "c" 'flyspell-auto-correct-word
      "C" 'flyspell-auto-correct-previous-word
      "a" 'align-regexp
      "d" 'dictcc
      "e" 'emojify-insert-emoji))


     (use-package evil-numbers
       :ensure t
       :bind (("M-+" . evil-numbers/inc-at-pt)
              ("M--" . evil-numbers/dec-at-pt))))


    ;; Autocompletion
(use-package company
  :defer 10
  :diminish company-mode
  :bind (:map company-active-map
              ("M-j" . company-select-next)
              ("M-k" . company-select-previous))
  :preface
  ;; enable yasnippet everywhere
  (defvar company-mode/enable-yas t
    "Enable yasnippet for all backends.")
  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))

  :init (global-company-mode t)
  :config
  ;; no delay no autocomplete
  (validate-setq
   company-idle-delay 0
   company-minimum-prefix-length 2
   company-tooltip-limit 20)

  (validate-setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

  ;; Sort company candidates by statistics
  (use-package company-statistics
    :ensure t
    :config (company-statistics-mode)))

;; Snippets
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :init (yas-global-mode t)
  :config
  ;; preserve tab-completion in ansi-term
  (setq yas-indent-line 'auto)
  (setq yas-also-auto-indent-first-line t)
  (add-hook 'term-mode-hook (lambda()
                              (setq yas-dont-activate-functions t))))

;; Code-comprehension server
(use-package ycmd
  :ensure t
  :init (add-hook 'c++-mode-hook #'ycmd-mode)
  :config
  (set-variable 'ycmd-server-command '("python2" "/opt/GIT-Repos/ycmd/ycmd"))
  (set-variable 'ycmd-global-config (expand-file-name "~/Dotfiles/ycmd/ycm_conf.py"))

  (use-package flycheck-ycmd
    :commands (flycheck-ycmd-setup)
    :init (add-hook 'ycmd-mode-hook 'flycheck-ycmd-setup))

  (use-package company-ycmd
    :ensure t
    :init (company-ycmd-setup)
    :config (add-to-list 'company-backends (company-mode/backend-with-yas 'company-ycmd))))

;; Workspaces in emacs
(use-package perspeen
  :ensure t
  :init
  (setq perspeen-use-tab t)
  (global-unset-key (kbd "C-z"))
  :config
  (perspeen-mode t))


;; Emojis completion like Github/Slack
;; BUG emacs crashes when typing :in
;(use-package company-emoji
;  :ensure t
;  :init
;  (add-to-list 'company-backends 'company-emoji))
;; On-the-fly syntax checking

;;;;;;;;;;
;; Spell checking
;;;;;;;;;;

;; On-the-fly spell checking
(use-package flyspell
  :commands flyspell-buffer
  :bind (:map flyspell-mouse-map
              ("[down-mouse-3]" . ispell-word)
              ("[mouse-3]" . ispell-word))
  :preface
  (defun flyspell-detect-ispell-args (&optional RUN-TOGETHER)
    "If RUN-TOGETHER is true, spell check the CamelCase words."
    (let (args)
      (cond
       ((string-match  "aspell$" ispell-program-name)
        ;; force the English dictionary, support Camel Case spelling check (tested with aspell 0.6)
        (validate-setq args (list "--sug-mode=ultra" "--lang=en_US"))
        (if RUN-TOGETHER
            (setq args (append args '("--run-together" "--run-together-limit=5" "--run-together-min=2"))))))
      args))
  :init
  (dolist (hook '(text-mode-hook message-mode-hook LaTeX-mode-hook))
    (add-hook hook 'turn-on-flyspell))
  :diminish " \uF40E"
  :config
  (cond
   ((executable-find "aspell")
    (validate-setq ispell-program-name "aspell"))
   (t (validate-setq ispell-program-name nil)))

  ;; ispell-cmd-args is useless, it's the list of *extra* arguments we will
  ;; append to the ispell process when "ispell-word" is called.
  ;; ispell-extra-args is the command arguments which will *always* be used
  ;; when start ispell process
  (validate-setq ispell-extra-args (flyspell-detect-ispell-args t))

  (defadvice ispell-word (around my-ispell-word activate)
    (let ((old-ispell-extra-args ispell-extra-args))
      (ispell-kill-ispell t)
      (validate-setq ispell-extra-args (flyspell-detect-ispell-args))
      ad-do-it
      (validate-setq ispell-extra-args old-ispell-extra-args)
      (ispell-kill-ispell t))))


;; Spell checker
(use-package ispell
  :defer t
  :config
  (validate-setq
   ispell-program-name (executable-find "hunspell")
   ispell-dictionary "en_US")
  (unless ispell-program-name
    (warn "No spell-checker available. Please install Hunspell"))
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  (add-hook 'LaTeX-mode-hook 'flyspell-buffer)
  (add-hook 'markdown-mode-hook 'flyspell-mode)
  (add-hook 'markdown-mode-hook 'flyspell-buffer))


;; Automatically infer dictionary
(use-package auto-dictionary
  :ensure t
  :init
  (add-hook 'flyspell-mode-hook #'auto-dictionary-mode))

(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
         (change (if (string= dic "deutsch8") "english" "deutsch8")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

(global-set-key (kbd "<f8>")   'fd-switch-dictionary)


;; Emacs in server-mode
(use-package server
  :if (not noninteractive)
  :init (server-mode)
  :diminish server-buffer-clients)

;;;;;;;;;;
;; Programming languages support
;;;;;;;;;;
(require 'languages)

;;;;;;;;;;
;; Custom stuff
;;;;;;;;;;


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "a1289424bbc0e9f9877aa2c9a03c7dfd2835ea51d8781a0bf9e2415101f70a7e" default)))
 '(package-selected-packages
   (quote
    (web-mode helm-perspeen auto-async-byte-compile smooth-scrolling spaceline smart-mode-line-powerline-theme smart-mode-line smart-modeline perspeen powerline-evil eyebrowse java-snippets dictcc evil-leader company-auctex auctex-latexmk auctex markdown-mode magit-gitflow helm-swoop helm-dash helm-ag helm-projectile async magit flycheck-haskell company-tern company-inf-ruby rubocop robe auto-dictionary company-ycmd paradox git-gutter-fringe git-gutter multi-term evil-numbers emojify rainbow-delimiters dashboard spacemacs-theme powerline yasnippet company-statistics all-the-icons-dired sudo-edit all-the-icons rainbow-mode atom-dark-theme atom-one-dark-theme pdf-tools evil-surround)))
 '(paradox-github-token t)
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "InconsolataForPowerline Nerd Font" :foundry "PfEd" :slant normal :weight normal :height 102 :width normal)))))
;;; init.el ends here
(put 'dired-find-alternate-file 'disabled nil)

;;; languages.el -- Enable support for multiple languages
;;; Commentary:
;;; Integration of several programming languages.

;;;;;;;;;;
;; Programming languages support
;;;;;;;;;;

;;; Code:
;; Latex
(use-package tex
  ;ensure t
  :config
  (setq-default TeX-master nil) ; Query for master file.
  (add-to-list 'TeX-command-list
                  '("XeLaTeX" "xelatex -synctex=1 -interaction=nonstopmode --shell-escape %O %S"
                    TeX-run-command t t :help "Run xelatex") t)
  (setq-default TeX-engine 'xetex)
  (add-to-list 'TeX-view-program-list
                  '("Zathura" "zathura %o" TeX-run-command t t :help "Run zathura") t)
  (add-to-list 'TeX-view-program-selection
                  '(output-pdf "Zathura") t)
  (use-package reftex
    :config
    (autoload 'reftex-mode
      "reftex" "RefTeX Minor Mode" t)
    (autoload 'turn-on-reftex
      "reftex" "RefTeX Minor Mode" nil)
    (autoload 'reftex-citation
      "reftex-cite" "Make citation" nil)
    (autoload 'reftex-index-phrase-mode
      "reftex-index" "Phrase Mode" t)
    (add-hook 'latex-mode-hook 'turn-on-reftex)  ; with Emacs latex mode
    )
  (use-package tex-site
    :config)
  (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)    ; Use pdflatex instead of latex
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode) ;turn on math-mode by default
  (add-hook 'LaTeX-mode-hook 'TeX-interactive-mode)
  (add-hook 'doc-view-mode-hook 'auto-revert-mode)

  ;; Add bibtex file
  (setq reftex-default-bibliography
        '(expand-file-name "~/Documents/studies/BA/bachelorarbeit-event-sourced-graphs/bachlor-thesis/bib/literature.bib"))
  (use-package auctex-latexmk
    :config
    (auctex-latexmk-setup))
  )
    ;; (add-hook 'reftex-load-hook 'imenu-add-menubar-index)

;    (setq LaTeX-eqnarray-label "eq"
;          LaTeX-equation-label "eq"
;          LaTeX-figure-label "fig"
;          LaTeX-table-label "tab"
;          LaTeX-myChapter-label "chap"
;          reftex-plug-into-AUCTeX t
;          TeX-auto-save t
;          TeX-newline-function 'reindent-then-newline-and-indent
;          TeX-parse-self t
;;          TeX-style-path
;;          '("style/" "auto/"
;;            "/usr/share/emacs21/site-lisp/auctex/style/"
;;            "/var/lib/auctex/emacs21/"
;;            "/usr/local/share/emacs/site-lisp/auctex/style/")
;          LaTeX-section-hook
;          '(LaTeX-section-heading
;            LaTeX-section-title
;            LaTeX-section-toc
;            LaTeX-section-section
;            LaTeX-section-label))))



;; python
(use-package python
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
  :config
  (use-package elpy
    :config
    (validate-setq elpy-rpc-backend "jedi")
    (validate-setq elpy-modules (delq 'elpy-module-company elpy-modules))
    (elpy-enable)

    (add-hook 'python-mode-hook
              (lambda ()
                (company-mode)
                (add-to-list 'company-backends
                             (company-mode/backend-with-yas 'elpy-company-backend))))
    (elpy-use-cpython)))

;; Ruby
(use-package ruby-mode
  :mode "\\.rb\\'"
  :interpreter "ruby"
  :bind(:map
        ruby-mode-map
        ("C-c r" . onc/run-current-file))
  :config
  (use-package robe
    :ensure t
    :init
    (add-hook 'ruby-mode-hook #'robe-mode)
    (add-to-list 'company-backends (company-mode/backend-with-yas 'company-robe)))

  (use-package rubocop
    :ensure t)

  (use-package inf-ruby
    :ensure t
    :init
    (add-hook 'ruby-mode-hook #'inf-ruby-minor-mode)
    (add-hook 'compilation-filter-hook #'inf-ruby-auto-enter))

  (use-package company-inf-ruby
    :ensure t
    :config (add-to-list 'company-backends 'company-inf-ruby)))


;; Elisp
(use-package elisp-mode
  :interpreter ("emacs" . emacs-lisp-mode))


;; Javascript
(use-package js2-mode
  :mode "\\.js\\'"
  :config
  (setq-default js2-global-externs '("exports" "module" "require" "setTimeout" "THREE"))
  (setq-default js2-basic-offset 2))

(use-package tern
  :defer t
  :init
  (add-hook 'js-mode-hook (lambda () (tern-mode t)))
  (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
  (add-hook 'web-mode-hook (lambda () (tern-mode t)))
  :config
  (use-package company-tern
    :ensure t
    :config (add-to-list 'company-backends 'company-tern)))

;; Haskell
(use-package haskell-mode
  :mode "\\.hs\\'"
  :config
  (use-package flycheck-haskell
    :ensure t
    :init (add-hook 'haskell-mode-hook #'flycheck-haskell-setup)))

;; Zsh-files
(use-package sh-script
  :mode (("\\.zsh\\'" . sh-mode)
         ("\\zshrc\\'" . sh-mode)))
;; Yaml files
(use-package yaml-mode
  :mode (("\\.yml\\'" . yaml-mode)
         ("\\.yaml\\'" . yaml-mode)))

;; Gitignore files
(use-package gitignore-mode
  :mode "\\.gitignore\\'")

;; Markdown files
(use-package markdown-mode
  :mode (("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.mmd\\'" . markdown-mode))
  :init
  (add-hook 'markdown-mode-hook #'orgtbl-mode)
  (add-hook 'markdown-mode-hook
            (lambda()
              (add-hook 'after-save-hook 'org-tables-to-markdown  nil 'make-it-local)))
  :config
  (setq markdown-command "pandoc -f markdown -t html"))

;; Web-Mode for html, php and the like
(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
         ("\\.php\\'"   . web-mode)
         ("\\.jsp\\'"   . web-mode)
         ("\\.jsx\\'"   . web-mode)
         ("\\.erb\\'"   . web-mode))
  :config
  (validate-setq web-mode-markup-indent-offset 2
                 web-mode-code-indent-offset 2
                 web-mode-css-indent-offset 2
                 web-mode-code-indent-offset 2
                 web-mode-style-padding 1
                 web-mode-script-padding 1
                 web-mode-enable-current-element-highlight t
                 web-mode-enable-current-column-highlight t
                 ))

;; Json-files
(use-package json-mode
  :mode "\\.json\\'"
  :config
  ;(validate-setq js-indent-level 2)
  )


;; Dockerfiles
(use-package dockerfile-mode
  :mode "Dockerfile\\'")

;; rename modelines
;; http://whattheemacsd.com/appearance.el-01.html
(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))
     ))

;(rename-modeline "js2-mode" js2-mode "JS2")
;(rename-modeline "flyspell-mode" flyspell-mode ":man-with-gua-pi-mao-tone3:")


(provide 'languages)
;;; languages.el ends here

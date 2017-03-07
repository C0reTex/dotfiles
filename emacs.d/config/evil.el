(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(require 'evil)
(evil-mode 1)

;; Evil-Plugins
;; surround - helps you manage brackets.
;; https://github.com/timcharper/evil-surround
(require 'evil-surround)
(global-evil-surround-mode 1)

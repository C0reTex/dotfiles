;;; keybindings.el -- Key binding config
;;; Commentary:
;;;;;;;;;;
;; Keybindings
;;;;;;;;;;

;;; Code:
;; Map escape to cancel (like C-g)...
(define-key isearch-mode-map [escape] 'isearch-abort)   ;; isearch
(global-set-key [escape] 'keyboard-escape-quit)         ;; everywhere else

;; Keyboard shortcuts for resizing windows
(global-set-key (kbd "<C-s-h>") (lambda () (interactive) (shrink-window-horizontally 5)))
(global-set-key (kbd "<C-s-l>") (lambda () (interactive) (enlarge-window-horizontally 5)))
(global-set-key (kbd "<C-s-j>") (lambda () (interactive) (shrink-window 5)))
(global-set-key (kbd "<C-s-k>") (lambda () (interactive) (enlarge-window 5)))

(provide 'keybindings)
;;; keybindings.el ends here

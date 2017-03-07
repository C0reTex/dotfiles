;;; Code Completion
;; enable company-mode
(add-hook 'after-init-hook 'global-company-mode)
;; YouCompleteMe - https://github.com/Valloric/ycmd
(require 'ycmd)
(add-hook 'after-init-hook #'global-ycmd-mode)

;; how to start ycmd-server
(set-variable 'ycmd-server-command '("python" "/home/doctor/.emacs.d/ycmd"))

;; it's recommended to use _company-mode_ for completion
;; so that's what we're doing here.
(defun ycmd-setup-completion-at-point-function ()
  "Setup `completion-at-point-functions' for `ycmd-mode'."
  (add-hook 'completion-at-point-functions
	    #'ycmd-complete-at-point nil :local))

(add-hook 'ycmd-mode #'ycmd-setup-completion-at-point-function)

;; company-mode
(require 'company-ycmd)
(company-ycmd-setup)


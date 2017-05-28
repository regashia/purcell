;; Set EDITOR to emacsclient
(setenv "EDITOR" "emacsclient")

;; direnv
(when (maybe-require-package 'direnv)
  (direnv-mode))

(provide 'init-local)

;;; Theme
(require-package 'monokai-theme)
(require-package 'zenburn-theme)


;;; setenv
(setenv "EDITOR" "emacsclient")


;;; Unix style C-h
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
(define-key key-translation-map (kbd "M-h") (kbd "M-<DEL>"))
(define-key key-translation-map (kbd "C-?") (kbd "C-h"))
(define-key key-translation-map (kbd "M-?") (kbd "M-h"))


;;; C-a
(defun back-to-indentation-or-beginning ()
  (interactive)
  (if (= (point) (progn (back-to-indentation) (point)))
    (beginning-of-line)))

(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)


;;; M-m
(global-unset-key (kbd "M-m"))


;;; direnv
(when (maybe-require-package 'direnv)
  (direnv-mode))


;;; ddskk
(when (maybe-require-package 'ddskk)
  (setq skk-server-prog "google-ime-skk")      ; google-ime-skk の場所
  (setq skk-server-inhibit-startup-server nil) ; 辞書サーバが起動していなかったときに Emacs からプロセスを立ち上げる
  (setq skk-server-host "localhost")           ; サーバー機能を利用
  (setq skk-server-portnum 55100)              ; ポートは google-ime-skk
  (setq skk-share-private-jisyo t)             ; 複数 skk 辞書を共有

  ;; C-x C-j で skk-mode 起動
  (global-set-key (kbd "C-x C-j") 'skk-mode)
  ;; ミニバッファでは C-j を改行にしない
  (define-key minibuffer-local-map (kbd "C-j") 'skk-kakutei)
  ;; ";" を sticky キーに設定
  (setq skk-sticky-key ";")
  ;; isearch-mode でも使用可能にする
  (add-hook 'isearch-mode-hook 'skk-isearch-mode-setup)
  (add-hook 'isearch-mode-end-hook 'skk-isearch-mode-cleanup))


;;; Multi Term
(when (maybe-require-package 'multi-term)
  (global-set-key (kbd "M-m '") 'multi-term))


;;; EditorConfig
(when (maybe-require-package 'editorconfig)
  (editorconfig-mode 1))


;;; Markdown
(require-package 'markdown-preview-mode)

(provide 'init-local)

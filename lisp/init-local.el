;; Theme
(require-package 'zenburn-theme)

;; Set EDITOR to emacsclient
(setenv "EDITOR" "emacsclient")

;; direnv
(when (maybe-require-package 'direnv)
  (direnv-mode))

;; ddskk
(when (maybe-require-package 'ddskk)
  ;; google-ime-skk
  (setq skk-server-prog "google-ime-skk")      ; google-ime-skk の場所
  (setq skk-server-inhibit-startup-server nil) ; 辞書サーバが起動していなかったときに Emacs からプロセスを立ち上げる
  (setq skk-server-host "localhost")           ; サーバー機能を利用
  (setq skk-server-portnum 55100)              ; ポートは google-ime-skk
  (setq skk-share-private-jisyo t)             ; 複数 skk 辞書を共有

  ;; ミニバッファでは C-j を改行にしない
  (define-key minibuffer-local-map (kbd "C-j") 'skk-kakutei)
  ;; ¥ と \ を同じものとして扱う
  (define-key key-translation-map (kbd "C-¥") (kbd "C-\\"))
  ;; C-\ で skk-mode 起動
  (global-set-key (kbd "C-c C-j") 'skk-mode)
  ;; ";" を sticky キーに設定
  (setq skk-sticky-key ";"))

(provide 'init-local)

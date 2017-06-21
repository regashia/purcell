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


;;; Go
(when (maybe-require-package 'go-mode)
  (require-package 'company-go)
  (add-hook 'go-mode-hook
    (lambda ()
      (set (make-local-variable 'company-backends) '(company-go))
      (add-hook 'before-save-hook 'gofmt-before-save))))


;;; Rails
(projectile-rails-global-mode)


;;; HTML
(when (maybe-require-package 'web-mode)
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode)))


;;; eww
;; 背景・文字色を無効化する
(defvar eww-disable-colorize t)
(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))
(advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
(advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
(defun eww-disable-color ()
  "文字色を反映させない"
  (interactive)
  (setq-local eww-disable-colorize t)
  (eww-reload))
(defun eww-enable-color ()
  "文字色を反映させる"
  (interactive)
  (setq-local eww-disable-colorize nil)
  (eww-reload))

;; デフォルトの検索エンジンを Google に変更
(setq eww-search-prefix "http://www.google.co.jp/search?q=")

;; 複数起動可能
(defun eww-mode-hook--rename-buffer ()
  "Rename eww browser's buffer so sites open in new page."
  (rename-buffer "eww" t))
(add-hook 'eww-mode-hook 'eww-mode-hook--rename-buffer)

;; 画像はデフォルトで非表示
(defun eww-disable-images ()
  "画像表示させない"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image-alt)
  (eww-reload))
(defun eww-enable-images ()
  "画像表示させる"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image)
  (eww-reload))
(defun shr-put-image-alt (spec alt &optional flags)
  (insert alt))
;; はじめから非表示
(defun eww-mode-hook--disable-image ()
  (setq-local shr-put-image-function 'shr-put-image-alt))
(add-hook 'eww-mode-hook 'eww-mode-hook--disable-image)


;;; google-translate
(when (maybe-require-package 'google-translate)
  ;; 翻訳のデフォルト値を設定 (en -> zh)
  (custom-set-variables
    '(google-translate-default-source-language "en")
    '(google-translate-default-target-language "zh"))
  (global-set-key (kbd "M-m x g t") 'google-translate-at-point))

(provide 'init-local)

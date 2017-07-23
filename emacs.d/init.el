;;;
; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;; ------------------------------------------------------------------------
;; @ load-path

;;; load-pathの追加関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))
;;; load-pathに追加するフォルダ
; 2つ以上フォルダを指定する場合の引数 => (add-to-load-path "elisp" "xxx" "xxx")
(add-to-load-path "elisp")

;;; キーバインド
(global-unset-key "\C-t")

;;; パッケージ関連
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/")) ; MELPAを追加
(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/")) ; Marmaladeを追加
(package-initialize)

;;; 外観
(require 'appearance) ; color themeやfont関連は，elisp/appearance.elで指定）

(setq-default line-spacing 0) ; 行間

(global-hl-line-mode) ; 現在の行を目立たせる
(setq hl-line-face 'underline) ; 目立たせるスタイル

;(global-highlight-changes-mode t) ; 変更箇所を目立たせる

(show-paren-mode t) ; 対応する括弧をハイライト
(setq show-paren-delay 0) ; 強調表示のディレイ
(setq show-paren-style 'expression) ; 括弧内全体を強調
;(set-face-background 'show-paren-match-face "#500") ; 括弧内の色

; コメントの色
;(set-face-foreground 'font-lock-comment-face "pink")
(set-face-foreground 'font-lock-comment-delimiter-face "pink")

(column-number-mode t) ; 何文字目か表示
(line-number-mode t) ; 何行目か表示
(global-linum-mode t) ; 左側に評判号を表示

; タイトルバーにファイルのフルパスを表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name))
)

(setq-default show-trailing-whitespace t) ; 行末の空白を強調表示
(set-face-background 'trailing-whitespace "#b14770") ; 強調表示の色  


;;; 全角スペースとハードタブを強調表示
(global-whitespace-mode t)
(setq whitespace-space-regexp "\\(\u3000\\)")
(setq whitespace-style '(face tabs tab-mark spaces space-mark))
(setq whitespace-display-mappings ())
(set-face-foreground 'whitespace-tab "yellow")
(set-face-underline  'whitespace-tab t)
(set-face-foreground 'whitespace-space "yellow")
;(set-face-background 'whitespace-space "blue4")
(set-face-underline  'whitespace-space t)


;;; コード関連
(setq require-final-newline t) ; 末尾に必ず空行を挿入

(setq default-tab-width 4) ; tabの幅
(setq-default indent-tabs-mode nil) ; soft-tabを挿入


;;; emacsの挙動関連
(setq initial-scratch-message "") ; scratchの初期メッセージ消去
(which-function-mode 1) ; 関数名を表示
(setq visible-bell t) ; beepの代わりにwindowをブリンクさせる
(setq vc-follow-symlinks t) ; 自動でsymlinkを辿る
(setq mouse-drag-copy-region t) ; マウス選択で直ちにコピー．23まではdefault，24からnil．
(fset 'yes-or-no-p 'y-or-n-p) ; yes or noをy or n

;;; helm
(require 'helm-config)
(helm-mode t)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
;(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action) ; helm-find-filesでTab補完を有効にする
(define-key global-map (kbd "C-x b")   'helm-buffers-list)
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
(define-key global-map (kbd "C-c i")   'helm-imenu)

;;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/dotfiles/.emacs.d/auto-complete-dict")
(ac-config-default)

;;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)

;;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;;; rainbow-mode
(require 'rainbow-mode)
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'scss-mode-hook 'rainbow-mode)
(add-hook 'php-mode-hook 'rainbow-mode)
(add-hook 'html-mode-hook 'rainbow-mode)

;;; markdown-mode
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;; rainbow-delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;; web-mode
(require 'init-web-mode)

;;; js2-mode
;(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(setq-default js2-basic-offset 2)

;;; php-mode
(require 'php-mode)
(setq php-mode-force-pear t)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yaml-mode web-mode undo-tree solarized-theme rainbow-mode rainbow-delimiters php-mode markdown-mode js2-mode helm gitignore-mode gitconfig-mode git-commit-mode flycheck auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

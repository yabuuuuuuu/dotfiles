;;; Markdown mode
(add-to-load-path "markdown-mode")
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)

; markdown-modeで開くファイルの指定
(setq auto-mode-alist (cons '("\\.md" . gfm-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.markdown" . gfm-mode) auto-mode-alist))

; Markdownファイルのプレビュー
; C-c C-c mでバッファにプレビュ　C-c C-c pでブラウザでプレビュー
; C-c C-c eでhtmlに変換して保存
(setq markdown-command "perl ~/dotfiles/.emacs.d/Markdown_1.0.1/Markdown.pl")

;;; Markdownの見出し検索
; C-c C-s
(defun markdown-header-list ()
  "Show Markdown Formed Header list through temporary buffer."
  (interactive)
  (occur "^\\(#+\\|.*\n===+\\|.*\n\---+\\)")
  (other-window 1))
(require 'markdown-mode)
(define-key markdown-mode-map "\C-c\C-s" 'markdown-header-list)

(provide 'md)

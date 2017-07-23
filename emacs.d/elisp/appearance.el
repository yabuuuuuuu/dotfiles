;;; 表示関連

; Solarizedテーマの適用
;(load-theme 'solarized-dark t) ; または(load-theme 'solarized-light t)

;;; 実行環境による場合分け
(if (display-graphic-p)
    (progn
      ;; use a window system such as X
      ; フォントの指定（Solarizedテーマ適用時にcocoa版でコメントが豆腐化するのを防止）
      (when (x-list-fonts "Ricty")
	(let* ((size 14)
	       (asciifont "Ricty")
	       (jpfont "Ricty")
	       (h (* size 10))
	       (fontspec)
	       (jp-fontspec))
	  (set-face-attribute 'default nil :family asciifont :height h)
	  (setq fontspec (font-spec :family asciifont))
	  (setq jp-fontspec (font-spec :family jpfont))
	  (set-fontset-font nil 'japanese-jisx0208 jp-fontspec)
	  (set-fontset-font nil 'japanese-jisx0212 jp-fontspec)
	  (set-fontset-font nil 'japanese-jisx0213-1 jp-fontspec)
	  (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
	  (set-fontset-font nil '(#x0080 . #x024F) fontspec)
	  (set-fontset-font nil '(#x0370 . #x03FF) fontspec))
        )
      (tool-bar-mode 0)
	  
    )
    ;; text-olny terminal
    
)


(provide 'appearance)

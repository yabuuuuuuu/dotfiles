;;; flymake (Emacs22から標準添付されている)

(when (require 'flymake nil t)

  ;(global-set-key "\C-cd" 'flymake-display-err-menu-for-current-line)
  ; エラーをミニバッファに表示
  (defun flymake-show-and-sit ()
    "Displays the error/warning for the current line in the minibuffer"
    (interactive)
    (progn
      (let* ((line-no (flymake-current-line-no) )
	     (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
	     (count (length line-err-info-list)))
	(while (> count 0)
	  (when line-err-info-list
	    (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
		   (full-file
		    (flymake-ler-full-file (nth (1- count) line-err-info-list)))
		   (text (flymake-ler-text (nth (1- count) line-err-info-list)))
		   (line (flymake-ler-line (nth (1- count) line-err-info-list))))
	      (message "[%s] %s" line text)))
	  (setq count (1- count)))))
    (sit-for 60.0))
  (global-set-key "\C-cd" 'flymake-show-and-sit)

  ;; PHP用設定
  (when (not (fboundp 'flymake-php-init))
    ;; flymake-php-initが未定義のバージョンだったら、自分で定義する
    (defun flymake-php-init ()
      (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-inplace))
             (local-file  (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
        (list "php" (list "-f" local-file "-l"))))
    (setq flymake-allowed-file-name-masks
          (append
           flymake-allowed-file-name-masks
           '(("\\.php[345]?$" flymake-php-init))))
    (setq flymake-err-line-patterns
          (cons
           '("\\(\\(?:Parse error\\|Fatal error\\|Warning\\): .*\\) in \\(.*\\) on line \\([0-9]+\\)" 2 3 nil 1)
           flymake-err-line-patterns)))

  ;; JavaScript用設定
  (when (not (fboundp 'flymake-javascript-init))
    ;; flymake-javascript-initが未定義のバージョンだったら、自分で定義する
    (defun flymake-javascript-init ()
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        ;;(list "js" (list "-s" local-file))
        (list "jsl" (list "-process" local-file))
        ))
    (setq flymake-allowed-file-name-masks
          (append
           flymake-allowed-file-name-masks
           '(("\\.json$" flymake-javascript-init)
             ("\\.js$" flymake-javascript-init))))
    (setq flymake-err-line-patterns
          (cons
           '("\\(.+\\)(\\([0-9]+\\)): \\(?:lint \\)?\\(\\(?:warning\\|SyntaxError\\):.+\\)" 1 2 nil 3)
           flymake-err-line-patterns))
    )

  ;; C
  (defun flymake-c-init ()
    (let* ((temp-file   (flymake-init-create-temp-buffer-copy
			 'flymake-create-temp-inplace))
	   (local-file  (file-relative-name
			 temp-file
			 (file-name-directory buffer-file-name))))
      (list "clang" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

  (push '("\\.c$" flymake-c-init) flymake-allowed-file-name-masks)

  ;; C++
  (defun flymake-cc-init ()
    (let* ((temp-file   (flymake-init-create-temp-buffer-copy
			 'flymake-create-temp-inplace))
	   (local-file  (file-relative-name
			 temp-file
			 (file-name-directory buffer-file-name))))
      (list "clang++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

  (push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)

  (add-hook 'php-mode-hook
            '(lambda() (flymake-mode t)))
  (add-hook 'javascript-mode-hook
            '(lambda() (flymake-mode t)))
  (add-hook 'c-mode-hook
	    '(lambda() (flymake-mode t)))
  (add-hook 'c++-mode-hook
	    '(lambda() (flymake-mode t)))

  )

(provide 'flymake-conf)

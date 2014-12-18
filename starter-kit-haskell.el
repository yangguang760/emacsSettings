
(defun pretty-lambdas-haskell ()
  (font-lock-add-keywords
   nil `((,(concat "(?\\(" (regexp-quote "\\") "\\)")
          (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                    ,(make-char 'greek-iso8859-7 107))
                    nil))))))

(starter-kit-install-if-needed 'haskell-mode)

(add-hook 'haskell-mode-hook 'run-starter-kit-coding-hook)
(when (window-system)
  (add-hook 'haskell-mode-hook 'pretty-lambdas-haskell))
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;; Ignore compiled Haskell files in filename completions
(add-to-list 'completion-ignored-extensions ".hi")

(defadvice haskell-mode-stylish-buffer (around skip-if-flycheck-errors activate)
  (unless (flycheck-has-current-errors-p 'error)
    ad-do-it))
(setq haskell-stylish-on-save t)

(starter-kit-install-if-needed 'ghc)

(starter-kit-install-if-needed 'shm)

(add-hook 'haskell-mode-hook 'structured-haskell-mode)
;; The following are apparently pretty good for solarized-light.
;;(set-face-background 'shm-current-face "#eee8d5")
;;(set-face-background 'shm-quarantine-face "lemonchiffon")

(starter-kit-install-if-needed 'flycheck)
;;(add-hook 'flycheck-mode-hook 'flycheck-haskell-setup)
(global-flycheck-mode)

(starter-kit-install-if-needed 'flyspell)
(add-hook 'haskell-mode-hook 'flyspell-prog-mode)

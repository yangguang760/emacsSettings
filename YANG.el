
(server-start)
(set-fontset-font "fontset-default" 'gb18030' ("Microsoft YaHei" . "unicode-bmp"))
(add-to-list 'load-path "~/.emacs.d")
(setq default-directory "~/")
(setq org-startup-indented t)
(require 'package)
(package-initialize)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
        package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
        package-archives)
(starter-kit-load "haskell")
(starter-kit-load "yasnippet")
(tool-bar-mode 0) 
(auto-image-file-mode t)
(add-hook 'org-mode-hook (lambda () 
                           (global-visual-line-mode t)))

(require 'evil)
(require 'evil-leader)
(require 'evil-org)
(require 'ace-jump-buffer)
(evil-mode 1)
(global-evil-leader-mode)
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)
(define-key evil-normal-state-map (kbd "C-w SPC") 'ace-jump-buffer)
(define-key evil-motion-state-map ":" 'smex)
(define-key evil-motion-state-map ";" 'evil-ex)

(require 'autopair)
(autopair-global-mode)

(require 'powerline)
(require 'moe-theme)
(require 'moe-theme-switcher)
(setq calendar-latitude +40)
(setq calendar-longitude +116)
;; Choose the one you like, (moe-light) or (moe-dark)

(setq moe-theme-resize-org-title '(2.2 1.8 1.6 1.4 1.2 1.0 1.0 1.0 1.0))
(moe-theme-set-color 'blue)
;;(require 'color-theme)
;;(color-theme-initialize)
;;(color-theme-oswald)
(setq truncate-lines nil)
(powerline-moe-theme)

(setq org-clock-persist 'history)
(setq org-clock-persistence t)
(setq org-log-done 'time)
(defun org-summary-todo (n-done n-not-done)
       "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
 (setq org-default-notes-file (concat org-directory "/notes.org"))
(add-hook 'org-agenda-mode-hook
   (lambda ()
     (define-key org-agenda-mode-map "j" 'org-agenda-next-line)
     (define-key org-agenda-mode-map "J" 'org-agenda-later)
     (define-key org-agenda-mode-map "K" 'org-agenda-earlier)
     ;;(define-key org-agenda-mode-map "I" 'org-pomodoro)
     (define-key org-agenda-mode-map "=" 'org-agenda-priority-up)
     (define-key org-agenda-mode-map [F12] 'org-agenda-columns)
     (define-key org-agenda-mode-map "k" 'org-agenda-previous-line)))



(setq org-agenda-files (list "~/org/plans.org" 
                                   "~/org/todos.org"
                             "~/org/notes.org"))

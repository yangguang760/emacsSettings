
;;(global-set-key (kbd "C-M-h") 'backward-kill-word)

(global-set-key (kbd "C-x \\") 'align-regexp)

;;(global-set-key (kbd "M-/") 'hippie-expand)

;;(global-set-key [f1] 'menu-bar-mode)

(define-key global-map (kbd "C-=") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

(require 'evil)
(require 'evil-leader)
(require 'evil-org)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)
(define-key evil-normal-state-map (kbd "C-w SPC") 'ace-jump-buffer)
(define-key evil-motion-state-map ":" 'helm-M-x)
(define-key evil-motion-state-map ";" 'evil-ex)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)

(require 'helm-config)
(helm-mode 1)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;;(global-set-key (kbd "C-w f") 'ido-find-file-other-window)
;;(global-set-key (kbd "C-x C-p") 'find-file-at-point)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)

;;(windmove-default-keybindings) ;; Shift+direction
;;(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1))) ;; back one
;;(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2))) ;; forward two

(global-set-key (kbd "C-x ^") 'join-line)

;;(global-set-key (kbd "C-x C-m") 'execute-extended-command)

(global-set-key (kbd "C-h a") 'apropos)

(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp
                 isearch-string
               (regexp-quote isearch-string))))))

(add-hook 'org-agenda-mode-hook
   (lambda ()
     (define-key org-agenda-mode-map "j" 'org-agenda-next-line)
     (define-key org-agenda-mode-map "J" 'org-agenda-later)
     (define-key org-agenda-mode-map "K" 'org-agenda-earlier)
    (define-key org-agenda-mode-map "I" 'org-pomodoro)
     (define-key org-agenda-mode-map "=" 'org-agenda-columns)
     (define-key org-agenda-mode-map "k" 'org-agenda-previous-line)))
(evil-ex-define-cmd "f[iles]" 'helm-find-files)
(evil-ex-define-cmd "ls" 'helm-mini)
(evil-leader/set-key-for-mode 'org-mode
  "t"  'org-show-todo-tree
  "a"  'org-agenda
  "i"  'org-pomodoro
  "o"  'org-clock-out
  "c"  'org-archive-subtree
  "l"  'evil-org-open-links
  "b" 'org-schedule
  "e" 'org-deadline
  )
(mapc (lambda (state)
        (evil-define-key state evil-org-mode-map
          (kbd "M-l") 'org-shiftmetaright
          (kbd "M-h") 'org-shiftmetaleft
          (kbd "M-k") 'org-shiftmetaup
          (kbd "M-j") 'org-shiftmetadown
          (kbd "M-o") '(lambda () (interactive)
                         (evil-org-eol-call
                          '(lambda()
                             (org-insert-heading)
                             (org-metaright))))
          (kbd "M-t") '(lambda () (interactive)
                         (evil-org-eol-call
                          '(lambda()
                             (org-insert-todo-heading nil)
                             (org-metaright))))
          ))
      '(normal insert))

(evil-define-key 'normal evil-org-mode-map
  "gh" 'outline-up-heading
  "gj" (if (fboundp 'org-forward-same-level) ;to be backward compatible with older org version
           'org-forward-same-level
          'org-forward-heading-same-level)
  "gk" (if (fboundp 'org-backward-same-level)
           'org-backward-same-level
          'org-backward-heading-same-level)
  "gl" 'outline-next-visible-heading
  "t" 'org-todo
  "b" 'org-schedule
  "e" 'org-deadline
  "E" 'org-set-effort
  "s" 'org-set-tags-command
  "C-w SPC" 'ace-jump-buffer
  "T" 'org-toggle-checkbox
  "o" '(lambda () (interactive) (evil-org-eol-call 'clever-insert-item))
  "O" '(lambda () (interactive) (evil-org-eol-call 'org-insert-heading))
  "$" 'org-end-of-line
  "^" 'org-beginning-of-line
  "<" 'org-toggle-heading
  ">" 'org-toggle-item
  "+" 'org-cycle-list-bullet
  "=" 'org-priority-up
  "-" 'org-priority-down
  (kbd "TAB") 'org-cycle)

(define-key global-map "\C-cl" 'org-store-link)

;;(define-key global-map "\C-x\C-r" 'rgrep)

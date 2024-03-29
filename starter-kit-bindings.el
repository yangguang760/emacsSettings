
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

(require 'bbdb)
 (evil-define-key 'motion bbdb-mode-map
  "\C-k"       'bbdb-delete-field-or-record
  "\C-x\C-s"   'bbdb-save
  "\C-x\C-t"   'bbdb-transpose-fields
  "\d"         'bbdb-prev-field ; DEL
  "\M-d"       'bbdb-dial
  "\t"         'bbdb-next-field ; TAB
  "+"          'bbdb-append-display
  "*"          'bbdb-do-all-records
  ";"          'bbdb-edit-foo
  "?"          'bbdb-help
  "!"          'bbdb-search-invert
  "="          'delete-other-windows
  "a"          'bbdb-add-mail-alias
  "A"          'bbdb-mail-aliases
  "C"          'bbdb-copy-records-as-kill
  "c"          'bbdb-create
  "d"          'bbdb-delete-field-or-record
  "e"          'bbdb-edit-field
  "h"          'bbdb-info
  "i"          'bbdb-insert-field
  "J"          'bbdb-next-field
  "j"          'bbdb-next-record
  "K"          'bbdb-prev-field
  "k"          'bbdb-prev-record
  "m"          'bbdb-mail
  "M"          'bbdb-mail-address
  "N"          'bbdb-next-field
  "n"          'bbdb-next-record
  "o"          'bbdb-omit-record
  "P"          'bbdb-prev-field
  "p"          'bbdb-prev-record
  "s"          'bbdb-save
  "T"          'bbdb-display-records-completely
  "t"          'bbdb-toggle-records-layout
  "u"          'bbdb-browse-url

  ;; Search keys
  "b"          'bbdb
  "/1"         'bbdb-display-records
  "/n"         'bbdb-search-name
  "/o"         'bbdb-search-organization
  "/p"         'bbdb-search-phone
  "/a"         'bbdb-search-address
  "/m"         'bbdb-search-mail
  "/N"         'bbdb-search-xfields
  "/x"         'bbdb-search-xfields
  "/c"         'bbdb-search-changed
  "/d"         'bbdb-search-duplicates
  "\C-xnw"     'bbdb-display-all-records
  "\C-xnd"     'bbdb-display-current-record
  )

(require 'magit)
(evil-set-initial-state 'magit-log-edit-mode 'insert)
(evil-set-initial-state 'git-commit-mode 'insert)

(defun evil-magit-rebellion-quit-keymode ()
  (interactive)
  (magit-key-mode-command nil))

(evil-set-initial-state 'magit-commit-mode 'motion)
(evil-define-key 'motion magit-commit-mode-map
  "\C-c\C-b" 'magit-show-commit-backward
  "\C-c\C-f" 'magit-show-commit-forward)

(evil-set-initial-state 'magit-status-mode 'motion)
(evil-define-key 'motion magit-status-mode-map
  "\C-f" 'evil-scroll-page-down
  "\C-b" 'evil-scroll-page-up
  "." 'magit-mark-item
  "=" 'magit-diff-with-mark
  "C" 'magit-add-log
  "I" 'magit-ignore-item-locally
  "S" 'magit-stage-all
  "U" 'magit-unstage-all
  "X" 'magit-reset-working-tree
  "d" 'magit-discard-item
  "i" 'magit-ignore-item
  "s" 'magit-stage-item
  "u" 'magit-unstage-item
  "z" 'magit-key-mode-popup-stashing)

(evil-set-initial-state 'magit-log-mode 'motion)
(evil-define-key 'motion magit-log-mode-map
  "." 'magit-mark-item
  "=" 'magit-diff-with-mark
  "e" 'magit-log-show-more-entries)

(evil-set-initial-state 'magit-wassup-mode 'motion)
(evil-define-key 'motion magit-wazzup-mode-map
  "." 'magit-mark-item
  "=" 'magit-diff-with-mark
  "i" 'magit-ignore-item)

(evil-set-initial-state 'magit-branch-manager-mode 'motion)
(evil-define-key 'motion magit-branch-manager-mode-map
  "a" 'magit-add-remote
  "c" 'magit-rename-item
  "d" 'magit-discard-item
  "o" 'magit-create-branch
  "v" 'magit-show-branches
  "T" 'magit-change-what-branch-tracks)

;; "1" 'magit-show-level-1
;; "2" 'magit-show-level-2
;; "3" 'magit-show-level-3
;; "4" 'magit-show-level-4
(evil-set-initial-state 'magit-mode 'motion)
(evil-define-key 'motion magit-mode-map
  "\M-1" 'magit-show-level-1-all
  "\M-2" 'magit-show-level-2-all
  "\M-3" 'magit-show-level-3-all
  "\M-4" 'magit-show-level-4-all
  "\M-H" 'magit-show-only-files-all
  "\M-S" 'magit-show-level-4-all
  "\M-h" 'magit-show-only-files
  "\M-s" 'magit-show-level-4
  "!" 'magit-key-mode-popup-running
  "$" 'magit-process
  "+" 'magit-diff-larger-hunks
  "-" 'magit-diff-smaller-hunks
  "=" 'magit-diff-default-hunks
  "/" 'evil-search-forward
  ":" 'evil-ex
  ";" 'magit-git-command
  "?" 'evil-search-backward
  "<" 'magit-key-mode-popup-stashing
  "A" 'magit-cherry-pick-item
  "B" 'magit-key-mode-popup-bisecting
  ;C  commit add log
  "D" 'magit-revert-item
  "E" 'magit-ediff
  "F" 'magit-key-mode-popup-pulling
  "G" 'evil-goto-line
  "H" 'magit-rebase-step
  ;I  ignore item locally
  "J" 'magit-key-mode-popup-apply-mailbox
  "K" 'magit-key-mode-popup-dispatch
  "L" 'magit-add-change-log-entry
  "M" 'magit-key-mode-popup-remoting
  "N" 'evil-search-previous
  ;O  undefined
  "P" 'magit-key-mode-popup-pushing
  ;Q  undefined
  "R" 'magit-refresh-all
  "S" 'magit-stage-all
  ;T  change what branch tracks
  "U" 'magit-unstage-all
  ;V  visual line
  "W" 'magit-diff-working-tree
  "X" 'magit-reset-working-tree
  "Y" 'magit-interactive-rebase
  "Z" 'magit-key-mode-popup-stashing
  "a" 'magit-apply-item
  "b" 'magit-key-mode-popup-branching
  "c" 'magit-key-mode-popup-committing
  ;d  discard
  "e" 'magit-diff
  "f" 'magit-key-mode-popup-fetching
  "g?" 'magit-describe-item
  "g$" 'evil-end-of-visual-line
  "g0" 'evil-beginning-of-visual-line
  "gE" 'evil-backward-WORD-end
  "g^" 'evil-first-non-blank-of-visual-line
  "g_" 'evil-last-non-blank
  "gd" 'evil-goto-definition
  "ge" 'evil-backward-word-end
  "gg" 'evil-goto-first-line
  "gj" 'evil-next-visual-line
  "gk" 'evil-previous-visual-line
  "gm" 'evil-middle-of-visual-line
  "h" 'magit-key-mode-popup-rewriting
  ;i  ignore item
  "j" 'magit-goto-next-section
  "k" 'magit-goto-previous-section
  "l" 'magit-key-mode-popup-logging
  "m" 'magit-key-mode-popup-merging
  "n" 'evil-search-next
  "o" 'magit-key-mode-popup-submodule
  "p" 'magit-cherry
  "q" 'magit-mode-quit-window
  "r" 'magit-refresh
  ;s  stage
  "t" 'magit-key-mode-popup-tagging
  ;u  unstage
  "v" 'magit-revert-item
  "w" 'magit-wazzup
  "x" 'magit-reset-head
  "y" 'magit-copy-item-as-kill
  ;z  position current line
  " " 'magit-show-item-or-scroll-up
  "\d" 'magit-show-item-or-scroll-down
  "\t" 'magit-toggle-section
  (kbd "<return>")   'magit-visit-item
  (kbd "C-<return>") 'magit-dired-jump
  (kbd "<backtab>")  'magit-expand-collapse-section
  (kbd "C-x 4 a")    'magit-add-change-log-entry-other-window
  (kbd "\M-d") 'magit-copy-item-as-kill)

;; Redefine some bindings if rigid key bindings are expected
(when magit-rigid-key-bindings
  (evil-define-key 'motion magit-mode-map
    "!" 'magit-git-command-topdir
    "B" 'undefined
    "F" 'magit-pull
    "J" 'magit-apply-mailbox
    "M" 'magit-branch-manager
    "P" 'magit-push
    "b" 'magit-checkout
    "c" 'magit-commit
    "f" 'magit-fetch-current
    "h" 'undefined
    "l" 'magit-log
    "m" 'magit-merge
    "o" 'magit-submodule-update
    "t" 'magit-tag
    "z" 'magit-stash))

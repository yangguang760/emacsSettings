
(server-start)
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

(defun qiang-font-existsp (font)
  (if (null (x-list-fonts font))
      nil t))

(defun qiang-make-font-string (font-name font-size)
  (if (and (stringp font-size)
           (equal ":" (string (elt font-size 0))))
      (format "%s%s" font-name font-size)
    (format "%s-%s" font-name font-size)))

(defvar bhj-english-font-size nil)
(defun qiang-set-font (english-fonts
                       english-font-size
                       chinese-fonts
                       &optional chinese-fonts-scale
                       )
  (setq chinese-fonts-scale (or chinese-fonts-scale 1.2))
  (save-excursion
    (with-current-buffer (find-file-noselect "~/org/emacs-font-size")
      (delete-region (point-min) (point-max))
      (insert (format "%s" english-font-size))
      (save-buffer)
      (kill-buffer)))
  (setq face-font-rescale-alist `(("Microsoft Yahei" . ,chinese-fonts-scale)
                                  ("Microsoft_Yahei" . ,chinese-fonts-scale)
                                  ("微软雅黑" . ,chinese-fonts-scale)
                                  ("WenQuanYi Zen Hei" . ,chinese-fonts-scale)))
  "english-font-size could be set to \":pixelsize=18\" or a integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
  (require 'cl)                         ; for find if
  (setq bhj-english-font-size english-font-size)
  (let ((en-font (qiang-make-font-string
                  (find-if #'qiang-font-existsp english-fonts)
                  english-font-size))
        (zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts))))

    ;; Set the default English font
    ;;
    ;; The following 2 method cannot make the font settig work in new frames.
    ;; (set-default-font "Consolas:pixelsize=18")
    ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
    ;; We have to use set-face-attribute
    (set-face-attribute
     'default nil :font en-font)
    (set-face-font 'italic (font-spec :family "Courier New" :slant 'italic :weight 'normal :size (+ 0.0 english-font-size)))
    (set-face-font 'bold-italic (font-spec :family "Courier New" :slant 'italic :weight 'bold :size (+ 0.0 english-font-size)))

    (set-fontset-font t 'symbol (font-spec :family "Courier New"))
    (set-fontset-font t nil (font-spec :family "DejaVu Sans"))

    ;; Set Chinese font
    ;; Do not use 'unicode charset, it will cause the english font setting invalid
    (dolist (charset '(kana han cjk-misc bopomofo))
      (set-fontset-font t charset zh-font))))


(defvar bhj-english-fonts '("Monaco" "Consolas" "DejaVu Sans Mono" "Monospace" "Courier New"))
(defvar bhj-chinese-fonts '("Microsoft Yahei" "Microsoft_Yahei" "微软雅黑" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))

(qiang-set-font
 bhj-english-fonts
 (if (file-exists-p "~/.config/emacs-font-size")
     (save-excursion
       (find-file "~/.config/emacs-font-size")
       (goto-char (point-min))
       (let ((monaco-font-size (read (current-buffer))))
         (kill-buffer (current-buffer))
         monaco-font-size))
   12.5)
 bhj-chinese-fonts)

(defvar chinese-font-size-scale-alist nil)

;; On different platforms, I need to set different scaling rate for
;; differnt font size.
(cond
 ((and (boundp '*is-a-mac*) *is-a-mac*)
  (setq chinese-font-size-scale-alist '((10.5 . 1.3) (11.5 . 1.3) (16 . 1.3) (18 . 1.25))))
 ((and (boundp '*is-a-win*) *is-a-win*)
  (setq chinese-font-size-scale-alist '((11.5 . 1.25) (16 . 1.25))))
 (t ;; is a linux:-)
  (setq chinese-font-size-scale-alist '((16 . 1.25)))))

(defvar bhj-english-font-size-steps '(9 10.5 11.5 12.5 14 16 18 20 22))
(defun bhj-step-frame-font-size (step)
  (let ((steps bhj-english-font-size-steps)
        next-size)
    (when (< step 0)
        (setq steps (reverse bhj-english-font-size-steps)))
    (setq next-size
          (cadr (member bhj-english-font-size steps)))
    (when next-size
        (qiang-set-font bhj-english-fonts next-size bhj-chinese-fonts (cdr (assoc next-size chinese-font-size-scale-alist)))
        (message "Your font size is set to %.1f" next-size))))

(global-set-key [(control x) (meta -)] (lambda () (interactive) (bhj-step-frame-font-size -1)))
(global-set-key [(control x) (meta +)] (lambda () (interactive) (bhj-step-frame-font-size 1)))

(set-face-attribute 'default nil :font (font-spec))

; {%org-mode%}
; here are 20 hanzi and 40 english chars, see if they are the same width
; 你你你你你你你你你你你你你你你你你你你你
; aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
; /aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/
; {%/org-mode%}

; Local Variables:
; eval: (mmm-mode 1)
; End:

(require 'evil)
(require 'evil-leader)
(require 'evil-org)
(add-to-list 'load-path "~/.emacs.d/elpa/helm")
(require 'ace-jump-buffer)
(require 'relative-line-numbers)
(evil-mode 1)
(global-evil-leader-mode)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (emacs-lisp . t)
   (matlab . t)
   (C . t)
   (perl . t)
   (sh . t)
   (ditaa . t)
   (python . t)
   (haskell . t)
   (dot . t)
   (latex . t)
   (js . t)
   ))

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;;(global-relative-line-numbers-mode)

(require 'helm-config)
(helm-mode 1)

(require 'powerline)
(require 'moe-theme)
(require 'moe-theme-switcher)
(setq calendar-latitude +40)
(setq calendar-longitude +116)
;; Choose the one you like, (moe-light) or (moe-dark)

(setq moe-theme-resize-org-title '(1.3 1.2 1.1 1.0 1.0 1.0 1.0))
(moe-theme-set-color 'blue)
;;(require 'color-theme)
;;(color-theme-initialize)
;;(color-theme-oswald)
(setq truncate-lines nil)
(powerline-moe-theme)

(setq org-clock-persist 'history)
(setq org-clock-persistence t)
(setq org-agenda-buffer-tmp-name "*Org Agenda*")
(setq org-log-done 'time)
(setq org-log-repeat 'note)
(setq org-icalendar-use-scheduled '(todo-start event-if-todo))
(setq org-icalendar-use-scheduled '(todo-end event-if-todo))
(setq org-agenda-default-appointment-duration 60)

(defun org-summary-todo (n-done n-not-done)
       "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
 (setq org-default-notes-file (concat org-directory "/notes.org"))
(evil-ex-define-cmd "ls" 'helm-mini)
(setq org-mobile-directory "~/mobileorg")
(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
(setq org-reveal-root "file:///d:/reveal.js")
(setq org-agenda-files (list 
                                   "~/org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todos.org" "misc-todos")
             "* TODO %?\n  %x %i\n  %t")
        ("i" "Inbox" entry (file+headline "~/org/todos.org" "Inbox")
             "* %? :UNPLANNED:\n  %x %i\n  %t ")))

(require 'ox-latex)
(add-to-list 'org-latex-classes
             '("cn-article"
               "\\documentclass[10pt,a4paper]{article}
\\usepackage{graphicx}
\\usepackage{xcolor}
\\usepackage{xeCJK}
\\usepackage{lmodern}
\\usepackage{verbatim}
\\usepackage{fixltx2e}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{tikz}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{textcomp}
\\usepackage{listings}
\\usepackage{geometry}
\\usepackage{algorithm}
\\usepackage{algorithmic}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{latexsym}
\\usepackage{natbib}
\\usepackage{fancyhdr}
\\usepackage[xetex,colorlinks=true,CJKbookmarks=true,
linkcolor=blue,
urlcolor=blue,
menucolor=blue]{hyperref}
\\usepackage{fontspec,xunicode,xltxtra}
\\setmainfont[BoldFont=Microsoft YaHei]{Microsoft YaHei}  
\\setsansfont[BoldFont=Microsoft YaHei]{Microsoft YaHei}
\\setmonofont{Microsoft YaHei}  
\\newcommand\\fontnamemono{Microsoft YaHei}%等宽字体
\\newfontinstance\\MONO{\\fontnamemono}
\\newcommand{\\mono}[1]{{\\MONO #1}}
\\setCJKmainfont[Scale=0.9]{WenQuanYi Micro Hei}%中文字体
\\setCJKsansfont[Scale=0.9]{WenQuanYi Micro Hei}
\\setCJKmonofont[Scale=0.9]{WenQuanYi Micro Hei Mono}
\\hypersetup{unicode=true}
\\geometry{a4paper, textwidth=6.5in, textheight=10in,
marginparsep=7pt, marginparwidth=.6in}
\\definecolor{foreground}{RGB}{220,220,204}%浅灰
\\definecolor{background}{RGB}{62,62,62}%浅黑
\\definecolor{preprocess}{RGB}{250,187,249}%浅紫
\\definecolor{var}{RGB}{239,224,174}%浅肉色
\\definecolor{string}{RGB}{154,150,230}%浅紫色
\\definecolor{type}{RGB}{225,225,116}%浅黄
\\definecolor{function}{RGB}{140,206,211}%浅天蓝
\\definecolor{keyword}{RGB}{239,224,174}%浅肉色
\\definecolor{comment}{RGB}{180,98,4}%深褐色
\\definecolor{doc}{RGB}{175,215,175}%浅铅绿
\\definecolor{comdil}{RGB}{111,128,111}%深灰
\\definecolor{constant}{RGB}{220,162,170}%粉红
\\definecolor{buildin}{RGB}{127,159,127}%深铅绿
\\punctstyle{kaiming}
\\title{}
\\fancyfoot[C]{\\bfseries\\thepage}
\\chead{\\MakeUppercase\\sectionmark}
\\pagestyle{fancy}
\\tolerance=1000
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(add-to-list 'org-latex-classes
           '("article-zh"
             "
\\documentclass{article}
\\usepackage[slantfont, boldfont]{xeCJK}
\\setCJKmainfont{WenQuanYi Micro Hei}
\\setCJKsansfont{WenQuanYi Micro Hei}
\\setCJKmonofont{WenQuanYi Micro Hei Mono}
"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-latex-pdf-process '("xelatex -interaction nonstopmode -output-directory %o %f"
                              "xelatex -interaction nonstopmode -output-directory %o %f"
                              "xelatex -interaction nonstopmode -output-directory %o %f"))



  (defun sl/display-header ()
(setq header-line-format
       (list "-"

        'global-mode-string
)))



  (add-hook 'buffer-list-update-hook
            'sl/display-header)

(require 'gnus)
  (setq nnml-directory "~/gmail")
  (setq message-directory "~/gmail")
 (setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\”]\”[#’()]")
  (setq gnus-select-method
        '(nnimap "gmail"
                 (nnimap-address "imap.gmail.com")
                 (nnimap-server-port 993)
                 (nnimap-stream ssl)))

(require 'bbdb)
(require 'bbdb-autoloads)
(setq
 bbdb-file "~/.bbdb"
 bbdb-offer-save 'auto
 bbdb-notice-auto-save-file t
 bbdb-expand-mail-aliases t
 bbdb-canonicalize-redundant-nets-p t
 bbdb-always-add-addresses t
 bbdb-complete-name-allow-cycling t
 )

(require 'cal-china-x)
(setq mark-holidays-in-calendar t)
(setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
(setq calendar-holidays cal-china-x-important-holidays)

 (desktop-save-mode nil)
 (desktop-load-default)
(desktop-read)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(mode-line-format
   (quote
    ("%e"
     (:eval
      (let*
          ((active
            (powerline-selected-window-active))
           (mode-line
            (if active
                (quote mode-line)
              (quote mode-line-inactive)))
           (face1
            (if active
                (quote powerline-active1)
              (quote powerline-inactive1)))
           (face2
            (if active
                (quote powerline-active2)
              (quote powerline-inactive2)))
           (separator-left
            (intern
             (format "powerline-%s-%s" powerline-default-separator
                     (car powerline-default-separator-dir))))
           (separator-right
            (intern
             (format "powerline-%s-%s" powerline-default-separator
                     (cdr powerline-default-separator-dir))))
           (lhs
            (list
             (powerline-raw "%*" nil
                            (quote l))
             (powerline-buffer-size nil
                                    (quote l))
             (powerline-raw mode-line-mule-info nil
                            (quote l))
             (powerline-buffer-id nil
                                  (quote l))
             (when
                 (and
                  (boundp
                   (quote which-func-mode))
                  which-func-mode)
               (powerline-raw which-func-format nil
                              (quote l)))
             (powerline-raw " ")
             (funcall separator-left mode-line face1)
             (when
                 (boundp
                  (quote erc-modified-channels-object))
               (powerline-raw erc-modified-channels-object face1
                              (quote l)))
             (powerline-major-mode face1
                                   (quote l))
             (powerline-process face1)
             (powerline-minor-modes face1
                                    (quote l))
             (powerline-narrow face1
                               (quote l))
             (powerline-raw " " face1)
             (funcall separator-left face1 face2)
             (powerline-vc face2
                           (quote r))))
           (rhs
            (list
             (funcall separator-right face2 face1)
             (powerline-raw "%4l" face1
                            (quote l))
             (powerline-raw ":" face1
                            (quote l))
             (powerline-raw "%3c" face1
                            (quote r))
             (funcall separator-right face1 mode-line)
             (powerline-raw " ")
             (powerline-raw "%6p" nil
                            (quote r))
             (powerline-hud face2 face1))))
        (concat
         (powerline-render lhs)
         (powerline-fill face2
                         (powerline-width rhs))
         (powerline-render rhs)))))))
 '(relative-line-numbers-delay 1)
 '(show-paren-mode t)
 '(text-mode-hook (quote (text-mode-hook-identify)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monaco" :foundry "outline" :slant normal :weight normal :height 98 :width normal)))))

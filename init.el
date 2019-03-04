;; File :            init.el (.emacs file)
;; Version :         1.2.3
;; Last changed :    18/5/2016
;; Purpose :         serving no purpose
;; Author :          Mikael Kvist, mikael.stefan.kvist@cern.ch

(if window-system (setq x-select-enable-primary t))
(if window-system (setq x-select-enable-clipboard nil))
(setq select-active-regions nil)
(setq mouse-drag-copy-region t)
(global-set-key [mouse-2] 'mouse-yank-at-click)

;; TAB settings
;; (setq default-tab-width 2)
;; set current buffer's tab char's display width to 4 spaces
;; (setq tab-width 2)
;; (global-set-key (kbd "TAB") 'self-insert-command)
(global-set-key (kbd " ") 'self-insert-command)
(setq tab-stop-list (number-sequence 2 200 2))
(setq c-backspace-function 'backward-delete-char)

(setq-default c-basic-offset 2)

(setq-default indent-tabs-mode nil)

;; (defun my-generate-tab-stops (&optional width max)
;;   "Return a sequence suitable for `tab-stop-list'."
;;   (let* ((max-column (or max 200))
;;         (tab-width (or width tab-width))
;;          (count (/ max-column tab-width)))
;;     (number-sequence tab-width (* tab-width count) tab-width)))

;; (setq tab-width 4)
;; (setq tab-stop-list (my-generate-tab-stops))

;; delete the selected text when you press DEL, Ctrl-d, or Backspace
(delete-selection-mode t)
;; enable line numbers
(global-linum-mode t)

;; Don't want any startup message
(setq inhibit-startup-message   t)
;; Don't want any backup files
(setq make-backup-files         nil)
;; Highlight search object
(setq search-highlight           t)
;; Keep mouse high-lightening
(setq mouse-sel-retain-highlight t)
;; stop creating those #auto-save# files
(setq auto-save-default nil)

;; Color settings.
(set-background-color  "#2e3436")
(set-border-color      "#888a85")
(set-cursor-color      "#fce94f")
(set-foreground-color  "#eeeeec")
(set-mouse-color       "#8ae234")

;; turn on paren match highlighting
(show-paren-mode 1)

;; Show unnecessary spaces at the end of a line
(setq-default show-trailing-whitespace t)

;; Font size
(set-face-attribute 'default nil :height 110)

;; [Ctrl]-[G]
(global-set-key "\C-g" 'goto-line)

;; [Ctrl]-[Z]
(global-set-key "\C-z" 'undo)

(cua-mode t)
    (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
    (transient-mark-mode 1)               ;; No region when it is not highlighted
    (setq cua-keep-region-after-copy t)

(setq c-default-style "linux"
      c-basic-offset 2)
;; Highlight TODO
(font-lock-add-keywords 'c++-mode '(("\\(FIXME\\)" 1 '(:foreground "green") t)))
(font-lock-add-keywords 'c++-mode '(("\\(TODO\\)" 1 '(:foreground "green") t)))
(font-lock-add-keywords 'c++-mode '(("\\(todo\\)" 1 '(:foreground "green") t)))
(font-lock-add-keywords 'c++-mode '(("\\(nullptr\\)" 1 '(:foreground "cyan") t)))
(font-lock-add-keywords 'c-mode '(("\\(FIXME\\)" 1 '(:foreground "green") t)))
(font-lock-add-keywords 'c-mode '(("\\(TODO\\)" 1 '(:foreground "green") t)))
(font-lock-add-keywords 'c-mode '(("\\(todo\\)" 1 '(:foreground "green") t)))
;; Higlight syntax helper
(font-lock-add-keywords 'c++-mode '(("\\(if\\|^\\s-*while\\|for\\)\\s-*\\s(.*;$"
                                   1 '(:foreground "#ffd700") t)))
(font-lock-add-keywords 'c++-mode '(("\\(until\\)\\s-*\\s(.*$"
                                   1 '(:foreground "cyan") t)))
(font-lock-add-keywords 'c++-mode '(("\\(unless\\)\\s-*\\s(.*$"
                                   1 '(:foreground "cyan") t)))
(font-lock-add-keywords 'c++-mode '(("\\(assert\\)\\s-*\\s(.*$"
                                   1 '(:foreground "#b0c4de") t)))
(font-lock-add-keywords 'c++-mode '(("\\(if\\)\\s-*\\s(.*[^!<=>|&][=][^=]"
                                   1 '(:foreground "#ffd700") t)))
(font-lock-add-keywords 'c-mode '(("\\(if\\|^\\s-*while\\|for\\)\\s-*\\s(.*;$"
                                   1 '(:foreground "#ffd700") t)))
(font-lock-add-keywords 'c-mode '(("\\(until\\)\\s-*\\s(.*$"
                                   1 '(:foreground "cyan") t)))
(font-lock-add-keywords 'c-mode '(("\\(unless\\)\\s-*\\s(.*$"
                                   1 '(:foreground "cyan") t)))
(font-lock-add-keywords 'c-mode '(("\\(assert\\)\\s-*\\s(.*$"
                                   1 '(:foreground "#b0c4de") t)))
(font-lock-add-keywords 'c-mode '(("\\(if\\)\\s-*\\s(.*[^!<=>|&][=][^=]"
                                   1 '(:foreground "#ffd700") t)))


;; Window splitting
(global-set-key [f2] 'split-window-horizontally)
(global-set-key [f1] 'remove-split)

;; Remove trailing whitespaces
(global-set-key [f6] 'delete-trailing-whitespace)
;(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Warn in C for while();, if(x=0), ...
(global-set-key [f7] 'global-cwarn-mode)

(defvar script-name "/usr/local/src/SCRIPT/dmy")

(defun call-my-script-with-word ()
  (interactive)
  (shell-command
   (concat script-name
           " "
           (thing-at-point 'word))))
(global-set-key (kbd "C-c o") 'call-my-script-with-word)

;; Open files and goto lines like we see from g++ etc. i.e. file:line#
;; (to-do "make `find-file-line-number' work for emacsclient as well")
;; (to-do "make `find-file-line-number' check if the file exists")
(defadvice find-file (around find-file-line-number
                             (filename &optional wildcards)
                             activate)
  "Turn files like file.cpp:14 into file.cpp and going to the 14-th line."
  (save-match-data
    (let* ((matched (string-match "^\\(.*\\):\\([0-9]+\\):?$" filename))
           (line-number (and matched
                             (match-string 2 filename)
                             (string-to-number (match-string 2 filename))))
           (filename (if matched (match-string 1 filename) filename)))
      ad-do-it
      (when line-number
        ;; goto-line is for interactive use
        (goto-char (point-min))
        (forward-line (1- line-number))))))

;; Set the number to the number of columns to use.
(setq-default fill-column 79)

;; Turn on warn highlighting for characters outside of the 'width' char limit
(defun font-lock-width-keyword (width)
  "Return a font-lock style keyword for a string beyond width WIDTH
   that uses 'font-lock-warning-face'."
  `((,(format "^%s\\(.+\\)" (make-string width ?.))
     (1 font-lock-warning-face t))))

(font-lock-add-keywords 'python-mode (font-lock-width-keyword 80))
(font-lock-add-keywords 'c++-mode (font-lock-width-keyword 100))
(font-lock-add-keywords 'c-mode (font-lock-width-keyword 80))
(font-lock-add-keywords 'sh-mode (font-lock-width-keyword 80))

;; Whenever you open .tcc files, C++-mode will be used.
(add-to-list 'auto-mode-alist '("\\.tcc\\'" . c++-mode))
;; EOF

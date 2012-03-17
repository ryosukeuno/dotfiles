;; General
;; -------------------------------------------------------------

;; Basic setups
(require 'cl)
;(setq term-setup-hook 'vip-mode)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq delete-auto-save-files t)
(setq inhibit-startup-message t)
(setq kill-whole-line t)
(setq completion-ignore-case t)
(setq case-fold-search t)
(setq visible-bell t)
(setq partial-completion-mode 1)
(setq default-truncate-lines t)
(setq require-final-newline t)
(setq show-trailing-whitespace t)
(setq font-lock-maximum-decoration t)
(column-number-mode t)
(menu-bar-mode -1)
(show-paren-mode t)
(setq-default transient-mark-mode t)
(setq-default indent-tabs-mode nil)
(global-font-lock-mode 1)
(column-number-mode 1)
(windmove-default-keybindings)
(setq-default show-trailing-whitespace t)
(fset 'yes-or-no-p 'y-or-n-p)

;; diplay time
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-string-forms
      '((if display-time-day-and-date
          (format "%s/%s/%s(%s) %s:%s" year month day dayname 24-hours minutes))))
(display-time)

;; show line number
(global-linum-mode 1)
(setq linum-format
      (lambda (line)
        "Right justified line number format"
        (propertize (format
                     (let ((w (length (number-to-string
                                       (count-lines (point-min) (point-max))))))
                       (concat "%" (number-to-string w) "d| "))
                     line)
                    'face 'linum)))

;; character encoding utf8
(setq locale-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

;; set keys
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-c\C-h" 'help-command)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-t" 'other-window)
(global-set-key "\C-u" 'undo)
(global-set-key "\C-o" 'dabbrev-expand)
(global-set-key "\C-^" 'bs-cycle-next)
(global-set-key "\C-x;" 'comment-or-uncomment-region)
(global-set-key "\C-x\C-g" 'goto-line)
(global-set-key "\C-x\C-r" 'query-replace-regexp)
(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key "\M-n" '(lambda () (interactive) (dotimes (i 3) (next-line))))
(global-set-key "\M-p" '(lambda () (interactive) (dotimes (i 3) (previous-line))))

;; SKK
(require 'skk-autoloads)
(setq default-input-method "japanese-skk")
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)

(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
           "Prevent annoying \"Active processes exist\" query when you quit Emacs."
           (flet ((process-list ())) ad-do-it))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Langages
;; -------------------------------------------------------------

;; C
(setq c-default-style "linux")

;; Haskell
(autoload 'haskell-mode "haskell-mode" "Major mode for Haskell." t)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'font-lock-mode)
(add-hook 'haskell-mode-hook 'imenu-add-menubar-index)

;; Scheme
(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "scheme-mode" "Major mode for Scheme." t)
(autoload 'run-scheme "run-scheme" "Run an inferior Scheme process." t)
(define-key global-map "\C-cs"
            (lambda ()
              "Run scheme on other window"
              (interactive)
              (switch-to-buffer-other-window
                (get-buffer-create "*scheme*"))
              (run-scheme scheme-program-name)))


;; Functions
;; -------------------------------------------------------------

;; auto 'chmod +x <file>' when save file
(defun make-file-executable ()
  "Make the file of this buffer executable, when it is a script source."
  (save-restriction
    (widen)
    (if (string= "#!" (buffer-substring-no-properties 1 (min 3 (point-max))))
      (let ((name (buffer-file-name)))
        (or (equal ?. (string-to-char (file-name-nondirectory name)))
            (let ((mode (file-modes name)))
              (set-file-modes name (logior mode (logand (/ mode 4) 73)))
              (message (concat "Wrote " name " (+x)"))))))))
(add-hook 'after-save-hook 'make-file-executable)

;; go to beggining of line (skip indentation)
(defun beggining-of-indented-line (current-point)
  (interactive "d")
  (if (string-match
        "^[ \t]+$"
        (save-excursion
          (buffer-substring-no-properties
            (progn (beginning-of-line) (point))
            current-point)))
    (beginning-of-line)
    (back-to-indentation)))
(global-set-key "\C-a" 'beggining-of-indented-line)

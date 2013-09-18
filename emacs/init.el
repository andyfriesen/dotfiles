
(setq config-root (file-name-directory load-file-name))

(add-to-list 'load-path config-root)
(add-to-list 'load-path (concat config-root "site-lisp"))
(add-to-list 'load-path (concat config-root "haskell-mode"))
(add-to-list 'custom-theme-load-path (concat config-root "themes"))

(require 'flymake-cursor)
(require 'php-mode)
(require 'erlang)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(ac-config-default)

(when (featurep 'aquamacs)
  (load-theme 'solarized-dark t))

;(defun w32-maximize-frame ()
;  "Maximize the current frame"
;  (interactive)
;  (w32-send-sys-command 61488))

; Maximize emacs on startup 
;(add-hook 'window-setup-hook 'w32-maximize-frame t)

;; scroll one line at a time
(defun scroll-one-line-down (&optional arg)
  "Scroll the selected window down (backward in the text) one line (or N lines)."
  (interactive "p")
  (scroll-up (or arg 1)))
(defun scroll-one-line-up (&optional arg)
  "Scroll the selected window up (forward in the text) one line (or N)."
  (interactive "p")
  (scroll-down (or arg 1)))

; FIXME: Doesn't work. :(
;(defun show-window-menu (&optional arg)
;  "Stuff"
;  (interactive)
;  (w32-send-sys-command #xF100))
;(global-set-key [M-space] 'show-window-menu)

(global-set-key [C-up] 'scroll-one-line-up)
(global-set-key [C-down] 'scroll-one-line-down)

(defun my-c-mode-common-hook ()
    (setq
        tab-width 8
        indent-tabs-mode nil))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(define-key global-map (kbd "M-g")         'goto-line)

(setq auto-mode-alist
      (append
       (list
        ;(cons "\\.as$" 'ecmascript-mode)
        ;(cons "\\.js$" 'ecmascript-mode)
        (cons "\\.as$" 'javascript-mode)
        (cons "\\.scons$" 'python-mode)
        (cons "SConstruct" 'python-mode)
        (cons "SConscript" 'python-mode)
        (cons "\\.php$" 'php-mode)
        (cons "\\.mm$" 'objc-mode)
        (cons "\\.erl$" 'erlang-mode)
        (cons "\\.h$" 'c++-mode)
        (cons "\\.tml$" 'html-mode)
        (cons "\\.ts$" 'typescript-mode)
        )
       auto-mode-alist))

(setq-default truncate-lines t)
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(setq-default read-buffer-completion-ignore-case t)
(setq-default read-file-name-completion-ignore-case t)
(setq-default require-final-newline t)
(setq-default write-region-inhibit-fsync t)

(autoload 'typescript-mode "TypeScript" "TS!" t)

(require 'mouse)
(xterm-mouse-mode t)
(setq mouse-sel-mode t)

(unless (featurep 'aquamacs)
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (:height 58 :family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :width normal))))
   '(diff-added ((t (:inherit diff-changed :foreground "green"))))
   '(diff-context ((t (:inherit shadow :foreground "brightblue"))))
   '(diff-removed ((t (:inherit diff-changed :foreground "red"))))
   '(dired-ignored ((t (:inherit shadow :foreground "brightgreen"))))
   '(flymake-errline ((t (:foreground "brightred" :underline "red"))))
   '(flymake-warnline ((t (:foreground "magenta" :underline "yellow"))))
   '(font-lock-builtin-face ((t (:foreground "brightmagenta"))))
   '(font-lock-comment-face ((t (:foreground "brightgreen"))))
   '(font-lock-function-name-face ((t (:foreground "blue"))))
   '(font-lock-keyword-face ((t (:foreground "green"))))
   '(font-lock-string-face ((t (:foreground "cyan"))))
   '(font-lock-type-face ((t (:foreground "yellow"))))
   '(font-lock-variable-name-face ((t (:foreground "blue"))))
   '(minibuffer-prompt ((t (:foreground "blue" :weight bold))))
   '(region ((t (:background "brightwhite"))))))

(setq-default c-indent-tabs-mode t     ; Pressing TAB should cause indentation
              c-indent-level 4         ; A TAB is equivilent to four spaces
              c-argdecl-indent 0       ; Do not indent argument decl's extra
              c-tab-always-indent t
              backward-delete-function nil) ; DO NOT expand tabs when deleting

(c-add-style "my-c-style" '((c-continued-statement-offset 4))) ; If a statement continues on the next line, indent the continuation by 4

(defun my-c-mode-hook ()
  (c-set-style "my-c-style")
  (c-set-offset 'substatement-open '0) ; brackets should be at same indentation level as the statements they open
  (c-set-offset 'inline-open '+)
  (c-set-offset 'block-open '+)
  (c-set-offset 'brace-list-open '+)   ; all "opens" should be indented by the c-indent-level
  (c-set-offset 'case-label '+))       ; indent case labels by c-indent-level, too

(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)
(add-hook 'ecmascript-mode-hook 'my-c-mode-hook)

(load "haskell-site-file")

(autoload 'ghc-init "ghc" nil t)

;;(add-hook 'haskell-mode-hook (lambda ()
;;                               (local-set-key (kbd "C-c C-t") 'ghc-show-type)
;;                               ))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(haskell-indent-after-keywords (quote (("where" 2 0) ("of" 4) ("do" 4) ("mdo" 4) ("rec" 4) ("in" 4 0) ("{" 4) "if" "then" "else" "let")))
 '(haskell-indent-thenelse 1)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-tags-on-save t))

;(require 'speedbar)
;(speedbar-add-supported-extension ".hs")

(when (display-graphic-p)
  (custom-set-faces
   '(default ((t (:height 80 :family "Inconsolata")))))
  )

(defun change-to-cabal-directory ()
  (message "change-to-cabal-directory")
  (if (buffer-file-name)
      (change-to-cabal-directory-from-directory (file-name-directory buffer-file-name))))

(defun change-to-cabal-directory-from-directory (directory) 
  (if (file-accessible-directory-p directory)
      (if (find-cabal-files directory)
          (cd directory)

        (let ((parent-directory (file-name-directory
                                 (directory-file-name directory))))
          (unless (string= parent-directory directory)
            (change-to-cabal-directory-from-directory
             parent-directory))))))

(defun find-cabal-files (directory)
  (let ((file-list (directory-files directory)))
    (delq nil
          (mapcar (lambda (file) 
                    (if (> (length file) 6)
                        (string= (substring file (- 0 6)) ".cabal")
                      nil)) 
                  file-list))))

(require 'haskell-style)
(add-hook 'haskell-mode-hook 'haskell-style)

;; From the ghc-mod instructions
;(autoload 'ghc-init "ghc" nil t)
;; This should replace the call to add-hook from the ghc-mod instructions:
(add-hook 'haskell-mode-hook (lambda ()
                               (ghc-init)
                               (change-to-cabal-directory)
                               (flymake-mode)
                               (turn-on-haskell-indent)
                               (flymake-mode t)
                               (local-set-key [M-t] 'ghc-insert-template)))

(add-to-list 'completion-ignored-extensions ".hi")

(set-face-attribute 'default nil :height 60)


(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (file-exists-p (buffer-file-name)) (not (buffer-modified-p)))
        (revert-buffer t t t) )))
  (message "Refreshed open files.") )

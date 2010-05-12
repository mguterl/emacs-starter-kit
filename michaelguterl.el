;; add extra directories to path
(when (equal system-type 'darwin)
  (setenv "PATH" (concat "/opt/local/bin:/usr/local/bin:" (getenv "PATH")))
  (push "/opt/local/bin" exec-path))

(add-to-list 'load-path (concat dotfiles-dir "/vendor"))

;; Save backups in one place
;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!
(defvar autosave-dir
  (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))

(make-directory autosave-dir t)

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
          (if buffer-file-name
              (concat "#" (file-name-nondirectory buffer-file-name) "#")
            (expand-file-name
             (concat "#%" (buffer-name) "#")))))

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat "/tmp/emacs_backups/" (user-login-name) "/"))
(setq backup-directory-alist (list (cons "." backup-dir)))

;; Full screen toggle
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                         'fullboth)))

(global-set-key (kbd "M-n") 'toggle-fullscreen)

;; start server for emacsclient
(server-start)

;; misc
(prefer-coding-system 'utf-8)

;; map command as meta
(setq ns-command-modifier (quote meta))

;; cleanup trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; while I <square box> Unicode as much as the next guy,
;; I want my lambdas left alone.
(remove-hook 'coding-hook 'pretty-lambdas)

;; just nice to have everywhere
(add-hook 'coding-hook (lambda () (setq tab-width 2)))

;; tell ispell where to find the executable
(setq ispell-program-name "/opt/local/bin/aspell")

;; Bind M-\ to comment-or-uncomment-region
(global-set-key (kbd "M-\\") 'comment-or-uncomment-region)

;; cucumber support
(add-to-list 'load-path (concat dotfiles-dir "vendor/cucumber"))
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;; rhtml support
(add-to-list 'load-path (concat dotfiles-dir "vendor/rhtml"))
(require 'rhtml-mode)

;; haml and sass support
(require 'haml-mode)
(require 'sass-mode)

;; rspec support
(add-to-list 'load-path (concat dotfiles-dir "vendor/rspec"))
(require 'rspec-mode)
(load "rspec-mode-expectations")

;; ack support
(require 'ack-emacs)

;; rvm support
(add-to-list 'load-path (concat dotfiles-dir "vendor/rvm"))
(require 'rvm)

;; disable auto-fill-mode in ruby-mode
(add-hook 'rhtml-mode-hook
          (function (lambda ()
                      (auto-fill-mode)
                      )))

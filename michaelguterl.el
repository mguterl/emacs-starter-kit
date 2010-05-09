(add-to-list 'load-path (concat dotfiles-dir "vendor/cucumber"))
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

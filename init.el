(set-frame-font "Hack Nerd Font 14")
(prefer-coding-system 'utf-8-unix)
(set-language-environment "UTF-8")
(global-display-line-numbers-mode t)
(recentf-mode t)
(save-place-mode t)
(global-auto-revert-mode t)
(electric-pair-mode t) 
(put 'upcase-region 'disabled nil)

(setq iso-transl-char-map nil)
(setq inhibit-startup-screen t)
(setq auto-mode-case-fold nil)
(setq use-short-answers t)
(setq confirm-kill-processes nil)
(setq org-hide-emphasis-markers t)

(defvar user-setup-directory          (expand-file-name "setUp"          user-emacs-directory))
(defvar user-setup-builtins-directory (expand-file-name "setup/builtins" user-emacs-directory))
(defvar local-dev-package-directory   (expand-file-name "packages"       user-emacs-directory))
(defvar user-data-directory           (expand-file-name ""               user-emacs-directory))
(defvar user-cache-directory          (expand-file-name ".cache"         user-emacs-directory))
(defvar user-bin-directory            (expand-file-name "bin"            "~"))
(setq custom-file                     (expand-file-name "custom.el"      user-emacs-directory))
(setq backup-directory-alist '(("." . "~/.emacs.d/.emacs_saves")))
(make-directory user-cache-directory t)

(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

;; Packages
(use-package better-defaults)

(use-package solarized-theme
  :init (load-theme 'solarized-dark t))
         
(use-package projectile
  :init (projectile-mode t)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

(use-package yasnippet
  :init (yas-global-mode t))

(use-package yasnippet-snippets)

(use-package company
  :init (global-company-mode t))

(use-package evil)

(use-package smex
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)))

(use-package rainbow-delimiters
  :hook prog-mode)

(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode))

(use-package magit
  :bind (("C-c g" . magit-status)
         ("C-c C-g" . magit-status)))

(use-package format-all
  :init (format-all-mode t))

(use-package undo-tree
  :hook prog-mode org-mode
  :config
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))))

(use-package ido-vertical-mode
  :init (ido-vertical-mode t))

(use-package ace-jump-mode
  :bind ("C-c SPC" . ace-jump-mode))

(use-package vterm
  :bind ("C-c t" . vterm))

(use-package nov
  :mode ("\\.epub\\'" . nov-mode))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

;; LSP
(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
  (add-to-list 'eglot-server-programs '((rust-mode) "rust-analyzer"))
  (add-to-list 'eglot-server-programs '((python-mode) "pylsp"))
  (add-to-list 'eglot-server-programs '((java-mode) "jdtls"))
  :hook
  (c-mode . eglot-ensure)
  (c++-mode . eglot-ensure)
  (rust-mode . eglot-ensure)
  (python-mode . eglot-ensure)
  (java-mode . eglot-ensure))

(use-package rust-mode)

(use-package clojure-mode)
(use-package cider)

;; Keybinds (built-in)
(global-set-key (kbd "C-c f n") 'flymake-goto-next-error)
(global-set-key (kbd "C-c f p") 'flymake-goto-prev-error)

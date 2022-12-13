(load-theme 'modus-vivendi)

(prefer-coding-system 'utf-8-unix)
(set-language-environment "UTF-8")
(global-display-line-numbers-mode t)
(recentf-mode t)
(save-place-mode t)

(setq iso-transl-char-map nil)
(setq inhibit-startup-screen t)
(setq auto-mode-case-fold nil)

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
(use-package projectile)

(use-package smex
  :config
  (global-set-key (kbd "M-x") 'smex)                      
  (global-set-key (kbd "M-X") 'smex-major-mode-commands))

(use-package better-defaults)

(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode))
  
(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x C-g" . magit-status)))

(use-package clojure-mode)
(use-package cider)
(use-package inf-clojure)

(use-package evil)

(use-package rainbow-delimiters)

(use-package company)

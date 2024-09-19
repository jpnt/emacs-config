;;; init.el -- Main Emacs Configuration
;; Font size
(set-face-attribute 'default nil :height 140)

;; Restore reasonable garbage collection thresholds after startup
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 20 1024 1024))))  ;; 20MB

;; Disable excessive UI updates
(setq cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; Suppress warnings about the legacy advice API
(setq ad-redefinition-action 'accept)

;; Package management setup
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/"))
      package-archive-priorities '(("melpa" . 10) ("gnu" . 5)))
(package-initialize)

;; Use-package for efficient package management
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t
        use-package-always-defer t  ;; Defer loading by default to improve startup time
        use-package-verbose nil))   ;; Suppress verbose output for cleaner logs

;;; Performance Optimizations

;; Prevent excessive UI updates
(setq redisplay-skip-fontification-on-input t)

;; Auto-save and backup file management
(setq backup-directory-alist '(("." . "~/.emacs.d/.emacs_saves"))
      auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t))
      make-backup-files nil  ;; Disable backup files
      create-lockfiles nil)  ;; Disable lock files

;; Smooth scrolling and buffer configuration
(setq scroll-conservatively 101
      scroll-margin 1
      scroll-step 1
      mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-progressive-speed nil
      scroll-preserve-screen-position 1)

;;; UI Enhancements

;; Disable beeping and blinking to avoid distractions
(setq ring-bell-function 'ignore)
(blink-cursor-mode -1)

;; Configure recentf and savehist
(recentf-mode 1)
(savehist-mode 1)

;; Fringe and buffer boundaries
(set-fringe-mode 10)
(setq-default indicate-buffer-boundaries 'left)

;;; Ediff Configuration (single frame, horizontal split)
(setq ediff-window-setup-function 'ediff-setup-windows-plain
      ediff-split-window-function 'split-window-horizontally)

;; Relative line number
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;;; Core Plugins

;; Better defaults
(use-package better-defaults)

;; Fast navigation
(use-package ace-jump-mode
  :bind ("C-c SPC" . ace-jump-mode))

;; Better Mx, not Ivy
(use-package smex
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)))

(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode))

;; Which-key - Help with keybindings
(use-package which-key
  :init (which-key-mode t)
  :config (setq which-key-idle-delay 0.5))  ;; Show keybindings after 0.5s delay

;; Flycheck for on-the-fly syntax checking
(use-package flycheck
  :init (global-flycheck-mode t))

;; Super-save - Automatically save buffers on focus loss
(use-package super-save
  :init (super-save-mode t))

;; Undo-tree - Enhanced undo functionality
(use-package undo-tree
  :init (global-undo-tree-mode)
  :config (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))))

;; Vterm - Terminal emulator
(use-package vterm
  :bind ("C-c t" . vterm))

;; Projectile - Project management
(use-package projectile
  :init (projectile-mode t)
  :config (setq projectile-enable-caching t)  ;; Cache for faster project switching
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

;; Auto-completion
(use-package company
  :init (global-company-mode t))

;; Evil mode for Vim bindings
(setq evil-want-C-u-scroll t)
(use-package evil
  :init (evil-mode t))

;; Magit - Git integration
(use-package magit
  :bind (("C-c g" . magit-status)
         ("C-c C-g" . magit-status)))

;; Syntax highlighting for programming
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;;; Appearance Settings

;; Built-in Modus theme (dark)
(load-theme 'modus-vivendi t)

;;; LSP Configuration (eglot)
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

;;; Startup Optimization

;; Reduced GC threshold during operation (20MB)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 20 1024 1024))))

;; Set scratch buffer to fundamental-mode to reduce startup time
(setq initial-scratch-message nil
      initial-major-mode 'fundamental-mode)

;; Deferred loading of toolbars and menus to improve startup
(add-hook 'emacs-startup-hook (lambda () (tool-bar-mode -1)))

;; Startup time
(defun efs/display-startup-time ()
  (message
   "Emacs loaded in %s with %d garbage collections."
   (format
    "%.2f seconds"
    (float-time
     (time-subtract after-init-time before-init-time)))
   gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

(provide 'init)
;;; init.el ends here

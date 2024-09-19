;;; early-init.el -- Optimize Emacs startup

;; Disable unnecessary UI components to speed up startup
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Package management optimizations
(setq package-enable-at-startup nil
      package-quickstart t)  ;; Faster package loading by precompiling

;; Defer font setup to avoid memory overhead
(setq inhibit-compacting-font-caches t)

;; Increase garbage collection threshold for faster startup
(setq gc-cons-threshold most-positive-fixnum)

;; Skip loading of irrelevant files at startup (inspired by Doom Emacs)
(defvar startup/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist startup/file-name-handler-alist)))

;; Reduce frame resizing and screen noise during startup
(setq frame-inhibit-implied-resize t
      inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-splash-screen t
      inhibit-startup-echo-area-message t)

;; Prefer loading newer compiled .elc files
(setq load-prefer-newer t)

;; Native compilation optimizations (if Emacs supports it)
(when (fboundp 'native-compile)
  (setq native-comp-async-report-warnings-errors nil
        native-comp-deferred-compilation t))

;; Reduce initial startup noise
(setq initial-scratch-message nil
      initial-major-mode 'fundamental-mode)

;; Unset unused command-line options
(setq command-line-default-directory "~/")

;; Increase process chunk size for faster read/write operations
(setq read-process-output-max (* 1024 1024))  ;; 1MB

;; UTF-8 settings for consistency
(prefer-coding-system 'utf-8-unix)
(set-language-environment "UTF-8")

(provide 'early-init)
;;; early-init.el ends here

;;; My personal init.el
(setq user-full-name "Nikolai Schlegel")
(setq user-mail-address "nikolai.schlegel@gmail.com")

;;; ############################################################################
;;; Basic stuff that doesn't require additonal packages
;;; ############################################################################

;; Hide splash and startup
(setq inhibit-startup-message t
inhibit-startup-echo-area-message t)

;; Disable menu, scroll & tool bar
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)

;; Tooltip in echo area
(setq tooltip-use-echo-area t)

;; default Font & Frame Size
(add-to-list 'default-frame-alist '(font . "Source Code Pro-15"))
(add-to-list 'default-frame-alist '(height . 35))
(add-to-list 'default-frame-alist '(width . 85))

;; Fancy titlebar for MacOS
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon nil)
(setq frame-title-format nil)

;; Line numbers
(global-linum-mode 1)

;; Disable backups
(setq make-backup-files nil)
(setq auto-save-default nil)

;; show matching parentheses
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Ask "y" or "n" instead of "yes" or "no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Show trailing white spaces
(setq-default show-trailing-whitespace t)

;; Remove useless whitespace before saving a file
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))

;; Truncate lines
(setq-default 'truncate-lines t)

;; IDO
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-show-dot-for-dired t)
;; '(ido-ignore-extensions t)
(setq ido-use-filename-at-point (quote guess))

;; switch window
(global-set-key (kbd "M-o") 'other-window)

;; switch windows with cursor keys
(windmove-default-keybindings)

;;; ############################################################################
;;; Package Configs
;;; ############################################################################

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
			 ("gnu"   . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;;; ############################################################################
;;; Look & Feel from loaded packaged
;;; ############################################################################

;; My favorite Theme of the moment
(use-package jbeans-theme
	     :ensure t
	     :config
	     (load-theme 'jbeans t))

;;; ############################################################################
;;; Evil
;;; ############################################################################

;; Enable EVIL
(use-package evil
	     :ensure t
	     :config
	     (evil-mode 1))

(use-package evil-escape
  :ensure t
  :config
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.4)
  (setq-default evil-escape-unordered-key-sequence t)
  (evil-escape-mode t))

;;; ############################################################################
;;; Stuff needing clean-up
;;; ############################################################################
;; Racket mode
(setq racket-program "/usr/local/bin/racket")

;; ==========================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-safe-themes
   (quote
    ("7f9dc0c7bc8e5b4a1b9904359ee449cac91fd89dde6aca7a45e4ed2e4985664c" default)))
 '(linum-format " %3i ")
 '(package-selected-packages (quote (racket-mode)))
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:background "#222222" :foreground "#666666")))))

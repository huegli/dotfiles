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
(setq-default truncate-lines t)

;; IDO
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-show-dot-for-dired t)
;; '(ido-ignore-extensions t)
(setq ido-use-filename-at-point (quote guess))

;; use ibuffer for buffer management
(defalias 'list-buffers 'ibuffer-other-window)

;; Enable winner mode for window navigation
(winner-mode 1)

;; switch window
(global-set-key (kbd "M-o") 'other-window)

;; switch windows with cursor keys
(windmove-default-keybindings)

;;; ############################################################################
;;; Package Configs
;;; ############################################################################

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"         . "http://orgmode.org/elpa/")
			 ("gnu"          . "http://elpa.gnu.org/packages/")
			 ("melpa-stable" . "http://stable.melpa.org/packages/")
			 ("melpa"        . "http://melpa.org/packages/")))
(setq package-archive-priorities
      '(("melpa-stable" . 50)
	("gnu"          . 10)
	("org"          . 5)
	("melpa"        . 0)))
(package-initialize)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Experiment !!!
(use-package try
  :ensure t)

;;; ############################################################################
;;; Look & Feel from loaded package
;;; ############################################################################

;; My favorite Theme of the moment
(use-package jbeans-theme
  :ensure t
  :config
  (load-theme 'jbeans t))

;; Which-key helps with learning key combinations
(use-package which-key
  :ensure t
  :config (which-key-mode 1))

(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0)))))
))

;; avy navigation
(use-package avy
  :ensure t
  :bind ("M-g e" . avy-goto-word-1)
  :bind ("M-g f" . avy-goto-line)
  :bind ("M-g g" . avy-goto-char-2)
  :bind ("M-g w" . avy-goto-word-1)
  :bind ("C-:" . avy-goto-char)        ;; won't work in terminal
  :bind ("C-'" . avy-goto-char-timer)) ;; won't work in terminal

;; ido-vertical
(use-package ido-vertical-mode
  :ensure t
  :config
  (ido-vertical-mode 1)
  (setq ido-vertical-define-keys 'C-n-and-C-p-only))

;;; ############################################################################
;;; Evil
;;; ############################################################################

;; Enable EVIL
(use-package evil
  :ensure t
  :config (evil-mode 1))

(use-package evil-escape
  :ensure t
  :config
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.4)
  (setq-default evil-escape-unordered-key-sequence t)
  (evil-escape-mode t))

;; undefine some EVIL keys
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "M-.") nil))

;; my keys for EVIL mode
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "ga") 'avy-goto-char-timer)
  (define-key evil-normal-state-map (kbd "gl") 'avy-goto-line))

;;; ############################################################################
;;; Projects
;;; ############################################################################

;;; Projectile
(use-package projectile
  :ensure t
  :pin melpa-stable
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

;;; ############################################################################
;;; Development environmnts
;;; ############################################################################

;;; PlatformIO
(use-package platformio-mode
  :ensure t
)

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
 '(package-selected-packages
   (quote
    (ido-vertical-mode ace-window try platformio-mode projectile evil-escape evil jbeans-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0))))
 '(linum ((t (:background "#222222" :foreground "#666666")))))

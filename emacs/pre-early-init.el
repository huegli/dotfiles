;;; pre-early-init.el --- DESCRIPTION -*- no-byte-compile: t; lexical-binding: t; -*-

;; Reducing clutter in ~/.emacs.d by redirecting files to ~/emacs.d/var/
(setq minimal-emacs-var-dir (expand-file-name "var/" minimal-emacs-user-directory))
(setq package-user-dir (expand-file-name "elpa" minimal-emacs-var-dir))
(setq user-emacs-directory minimal-emacs-var-dir)

(setq custom-file null-device)

;; This configures some of the usual Mac OS command key shortcuts
(setq mac-option-modifier 'meta          
      mac-command-modifier 'super 
      mac-right-option-modifier 'meta
      mac-right-command-modifier 'none)

;; line numbers on the left for programing modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(add-to-list 'default-frame-alist '(undecorated-round . t))
(global-hl-line-mode 1)     ; enable cursor line
(set-fringe-mode 10)        ; Give some breathing room




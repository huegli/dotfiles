;;; post-init.el --- DESCRIPTION -*- no-byte-compile: t; lexical-binding: t; -*-

;; Auto-revert in Emacs is a feature that automatically updates the
;; contents of a buffer to reflect changes made to the underlying file
;; on disk.
(add-hook 'after-init-hook #'global-auto-revert-mode)

;; recentf is an Emacs package that maintains a list of recently
;; accessed files, making it easier to reopen files you have worked on
;; recently.
(add-hook 'after-init-hook #'recentf-mode)

;; savehist is an Emacs feature that preserves the minibuffer history between
;; sessions. It saves the history of inputs in the minibuffer, such as commands,
;; search strings, and other prompts, to a file. This allows users to retain
;; their minibuffer history across Emacs restarts.
(add-hook 'after-init-hook #'savehist-mode)

;; save-place-mode enables Emacs to remember the last location within a file
;; upon reopening. This feature is particularly beneficial for resuming work at
;; the precise point where you previously left off.
(add-hook 'after-init-hook #'save-place-mode)

(use-package vertico
  ;; (Note: It is recommended to also enable the savehist package.)
  :straight t
  :defer t
  :commands vertico-mode
  :hook (after-init . vertico-mode)
  :custom
  (vertico-count 25) 
  (vertico-resize t)
  :init
  ;; (vertico-buffer-mode)
  (vertico-indexed-mode))

(use-package orderless
 ;; Vertico leverages Orderless' flexible matching capabilities, allowing users
 ;; to input multiple patterns separated by spaces, which Orderless then
 ;; matches in any order against the candidates.
 :straight t
 :custom
 (completion-styles '(orderless basic))
 (completion-category-defaults nil)
 (completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
 ;; Marginalia allows Embark to offer you preconfigured actions in more contexts.
 ;; In addition to that, Marginalia also enhances Vertico by adding rich
 ;; annotations to the completion candidates displayed in Vertico's interface.
 :straight t
 :defer t
 :commands (marginalia-mode marginalia-cycle)
 :hook (after-init . marginalia-mode))

;;(use-package embark
;;  ;; Embark is an Emacs package that acts like a context menu, allowing
;;  ;; users to perform context-sensitive actions on selected items
;;  ;; directly from the completion interface.
;;  :ensure t
;;  :defer t
;;  :bind
;;  (("C-." . embark-act)         ;; pick some comfortable binding
;;   ("C-;" . embark-dwim)        ;; good alternative: M-.
;;   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
;;
;;  :init
;;  (setq prefix-help-command #'embark-prefix-help-command)
;;
;;  :config
;;  ;; Hide the mode line of the Embark live/completions buffers
;;  (add-to-list 'display-buffer-alist
;;               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
;;                 nil
;;                 (window-parameters (mode-line-format . none)))))

;;(use-package embark-consult
;;  :ensure t
;;  :hook
;;  (embark-collect-mode . consult-preview-at-point-mode))

(use-package consult
 :ensure t
 :bind (;; C-c bindings in `mode-specific-map'
        ("C-c M-x" . consult-mode-command)
        ("C-c h" . consult-history)
        ("C-c k" . consult-kmacro)
        ("C-c m" . consult-man)
        ("C-c r" . consult-recent-file)
        ("C-c i" . consult-imenu)
        ; ("C-c i" . consult-info)
        ([remap Info-search] . consult-info)
        ;; C-x bindings in `ctl-x-map'
        ("C-x M-:" . consult-complex-command)
        ("C-x b" . consult-buffer)
        ("C-x 4 b" . consult-buffer-other-window)
        ("C-x 5 b" . consult-buffer-other-frame)
        ("C-x t b" . consult-buffer-other-tab)
        ("C-x r b" . consult-bookmark)
        ("C-x p b" . consult-project-buffer)
        ;; Custom M-# bindings for fast register access
        ("M-#" . consult-register-load)
        ("M-'" . consult-register-store)
        ("C-M-#" . consult-register)
        ;; Other custom bindings
        ("M-y" . consult-yank-pop)
        ;; M-g bindings in `goto-map'
        ("M-g e" . consult-compile-error)
        ("M-g f" . consult-flymake)
        ("M-g g" . consult-goto-line)
        ("M-g M-g" . consult-goto-line)
        ("M-g o" . consult-outline)
        ("M-g m" . consult-mark)
        ("M-g k" . consult-global-mark)
        ("M-g i" . consult-imenu)
        ("M-g I" . consult-imenu-multi)
        ;; M-s bindings in `search-map'
        ("M-s d" . consult-find)
        ("M-s c" . consult-locate)
        ("M-s g" . consult-grep)
        ("M-s G" . consult-git-grep)
        ("M-s r" . consult-ripgrep)
        ("M-s l" . consult-line)
        ("M-s L" . consult-line-multi)
        ("M-s k" . consult-keep-lines)
        ("M-s u" . consult-focus-lines)
        ;; Isearch integration
        ("M-s e" . consult-isearch-history)
        :map isearch-mode-map
        ("M-e" . consult-isearch-history)
        ("M-s e" . consult-isearch-history)
        ("M-s l" . consult-line)
        ("M-s L" . consult-line-multi)
        ;; Minibuffer history
        :map minibuffer-local-map
        ("M-s" . consult-history)
        ("M-r" . consult-history))

 ;; Enable automatic preview at point in the *Completions* buffer.
 :hook (completion-list-mode . consult-preview-at-point-mode)

 :init
 ;; Optionally configure the register formatting. This improves the register
 (setq register-preview-delay 0.5
       register-preview-function #'consult-register-format)

 ;; Optionally tweak the register preview window.
 (advice-add #'register-preview :override #'consult-register-window)

 ;; Use Consult to select xref locations with preview
 (setq xref-show-xrefs-function #'consult-xref
       xref-show-definitions-function #'consult-xref)

 :config
 (consult-customize
  consult-theme :preview-key '(:debounce 0.2 any)
  consult-ripgrep consult-git-grep consult-grep
  consult-bookmark consult-recent-file consult-xref
  consult--source-bookmark consult--source-file-register
  consult--source-recent-file consult--source-project-recent-file
  ;; :preview-key "M-."
  :preview-key '(:debounce 0.4 any))
 (setq consult-narrow-key "<"))

;; (defun meow-setup ()
;;   (setq meow-cheatsheet-layout meow-cheatsheet-layout-dvorak)
;;   (meow-leader-define-key
;;    '("1" . meow-digit-argument)
;;    '("2" . meow-digit-argument)
;;    '("3" . meow-digit-argument)
;;    '("4" . meow-digit-argument)
;;    '("5" . meow-digit-argument)
;;    '("6" . meow-digit-argument)
;;    '("7" . meow-digit-argument)
;;    '("8" . meow-digit-argument)
;;    '("9" . meow-digit-argument)
;;    '("0" . meow-digit-argument)
;;    '("/" . meow-keypad-describe-key)
;;    '("?" . meow-cheatsheet))
;;   (meow-motion-overwrite-define-key
;;    ;; custom keybinding for motion state
;;    '("<escape>" . ignore))
;;   (meow-normal-define-key
;;    '("0" . meow-expand-0)
;;    '("9" . meow-expand-9)
;;    '("8" . meow-expand-8)
;;    '("7" . meow-expand-7)
;;    '("6" . meow-expand-6)
;;    '("5" . meow-expand-5)
;;    '("4" . meow-expand-4)
;;    '("3" . meow-expand-3)
;;    '("2" . meow-expand-2)
;;    '("1" . meow-expand-1)
;;    '("-" . negative-argument)
;;    '(";" . meow-reverse)
;;    '("," . meow-inner-of-thing)
;;    '("." . meow-bounds-of-thing)
;;    '("<" . meow-beginning-of-thing)
;;    '(">" . meow-end-of-thing)
;;    '("a" . meow-append)
;;    '("A" . meow-open-below)
;;    '("b" . meow-back-word)
;;    '("B" . meow-back-symbol)
;;    '("c" . meow-change)
;;    '("d" . meow-delete)
;;    '("D" . meow-backward-delete)
;;    '("e" . meow-line)
;;    '("E" . meow-goto-line)
;;    '("f" . meow-find)
;;    '("g" . meow-cancel-selection)
;;    '("G" . meow-grab)
;;    '("h" . meow-left)
;;    '("H" . meow-left-expand)
;;    '("i" . meow-insert)
;;    '("I" . meow-open-above)
;;    '("j" . meow-join)
;;    '("k" . meow-kill)
;;    '("l" . meow-till)
;;    '("m" . meow-mark-word)
;;    '("M" . meow-mark-symbol)
;;    '("n" . meow-next)
;;    '("N" . meow-next-expand)
;;    '("o" . meow-block)
;;    '("O" . meow-to-block)
;;    '("p" . meow-prev)
;;    '("P" . meow-prev-expand)
;;    '("q" . meow-quit)
;;    '("Q" . meow-goto-line)
;;    '("r" . meow-replace)
;;    '("R" . meow-swap-grab)
;;    '("s" . meow-search)
;;    '("t" . meow-right)
;;    '("T" . meow-right-expand)
;;    '("u" . meow-undo)
;;    '("U" . meow-undo-in-selection)
;;    '("v" . meow-visit)
;;    '("w" . meow-next-word)
;;    '("W" . meow-next-symbol)
;;    '("x" . meow-save)
;;    '("X" . meow-sync-grab)
;;    '("y" . meow-yank)
;;    '("z" . meow-pop-selection)
;;    '("'" . repeat)
;;    '("<escape>" . ignore)))

;; (use-package meow
;;   :straight t
;;   :config
;;   (meow-setup)
;;   (meow-global-mode 1))

(use-package xah-fly-keys
  :straight t
  :custom
  (xah-fly-use-control-key t)
  (xah-fly-use-meta-key t)
  :config
  (xah-fly-keys-set-layout "dvorak")
  (xah-fly-keys 1))

(use-package which-key
  :straight t
  :config
  (which-key-mode)
  :custom
  (which-key-max-description-length 40)
  (which-key-lighter nil)
  (which-key-sort-order 'which-key-prefix-then-key-order))

;;; Org-mode
(defun huegli/org-mode-setup()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq line-spacing 10))

(defun huegli/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "º"))))))
  (dolist (face '((org-level-1 . 1.5)
		(org-level-2 . 1.2)
		(org-level-3 . 1.1)
		(org-level-4 . 1.0)
		(org-level-5 . 0.9)
		(org-level-6 . 0.5)
		(org-level-7 . 0.5)
		(org-level-8 . 0.5)))
    (set-face-attribute (car face) nil :font "ETBembo" :weight 'Regular :height (cdr face)))
  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit 'fixed-pitch)
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(use-package org
  :ensure nil
  :defer t
  :hook (org-mode . huegli/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
	    org-hide-emphasis-marker t)
  (huegli/org-font-setup)
  (global-set-key (kbd "C-c l") #'org-store-link)
  (global-set-key (kbd "C-c a") #'org-agenda)
  (global-set-key (kbd "C-c c") #'org-capture)
  (setq org-work-directory "/Users/nikolai/Library/Mobile\ Documents/com~apple~icloud~applecorporate/Documents/Org")
  (setq beorg-directory "/Users/nikolai/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org")
  (setq org-directory beorg-directory)
  (setq org-default-notes-file (concat org-directory "/inbox.org")))

(defun huegli/org-mode-visual-fill ()
  (setq visual-fill-column-width 100 
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :straight t
  :hook (org-mode . huegli/org-mode-visual-fill))

(use-package org-bullets
  :after org
  :straight t
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))


(use-package org-mac-link
  :after org
  :straight t
  :config
  (add-hook 'org-mode-hook (lambda ()
			                 (define-key org-mode-map (kbd "C-c g") 'org-mac-link-get-link))))

(use-package exec-path-from-shell
  :straight t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package pdf-tools
  :straight t
  :config
  (pdf-loader-install))

(use-package casual
  :straight t
  :bind (:map dired-mode-map
              ("C-o" . #'casual-dired-tmenu)
              ("s" . #'casual-dired-sort-by-tmenu)
              ("/" . #'casual-dired-search-replace-tmenu)

          :map bookmark-bmenu-mode-map
              ("C-o" . #'casual-bookmarks-tmenu)
              ("J" . #'bookmark-jump)

           :map ibuffer-mode-map
              ("C-o" . #'casual-ibuffer-tmenu)
              ("F" . #'casual-ibuffer-filter-tmenu)
              ("s" . #'casual-ibuffer-sortby-tmenu)))

(use-package ibuffer
  :hook (ibuffer-mode . ibuffer-auto-mode)
  :defer t)
;; (use-package casual-ibuffer
;;   :straight t
;;   :bind (:map
;;          ibuffer-mode-map
;;          ("C-o" . casual-ibuffer-tmenu)
;;          ("F" . casual-ibuffer-filter-tmenu)
;;          ("s" . casual-ibuffer-sortby-tmenu)
;;          ("<double-mouse-1>" . ibuffer-visit-buffer) ; optional
;;          ("M-<double-mouse-1>" . ibuffer-visit-buffer-other-window) ; optional
;;          ("{" . ibuffer-backwards-next-marked) ; optional
;;          ("}" . ibuffer-forward-next-marked)   ; optional
;;          ("[" . ibuffer-backward-filter-group) ; optional
;;          ("]" . ibuffer-forward-filter-group)  ; optional
;;          ("$" . ibuffer-toggle-filter-group))  ; optional
;;   :after (ibuffer))
;; 
;; (use-package casual-isearch
;;   :straight t
;;   :bind (:map isearch-mode-map ("C-o" . casual-isearch-tmenu)))

;; (use-package helm
;;   :straight t)
;; 
;; (use-package helm-gtags
;;   :straight t)

;; (use-package vterm
;;   :straight t
;;   :defer t
;;   :commands vterm
;;   :config
;;   ;; Speed up vterm
;;   (setq vterm-timer-delay 0.01))

;; (use-package projectile
;;   :straight t
;;   :init
;;   (projectile-mode +1)
;;   :bind (:map projectile-mode-map
;;               ("s-p" . projectile-command-map)
;;               ("C-c p" . projectile-command-map)))

(use-package denote
  :straight t
  :commands (denote-directory)
  :custom
  ((denote-directory "/Users/nikolai/Library/CloudStorage/Dropbox/Denote")
   (denote-file-type 'org)
   (denote-known-keywords '("emacs" "macosx" "stephanie" "mikhaila" "sandiego" "financials" "programing"))
   (denote-date-prompt-use-org-read-date t)
   (denote-dired-directories '("/Users/nikolai/Library/CloudStorage/Dropbox/Denote"
                               "/Users/nikolai/Library/CloudStorage/Dropbox/Statements 2024"
                               "/Users/nikolai/Desktop"
                               "/Users/nikolai/Downloads"))
   (denote-dired-directories-include-subdirectories t))
  :config
  (setq denote-journal-extras-title-format 'day-date-month-year)
  (add-hook 'dired-mode-hook #'denote-dired-mode-in-directories))

(use-package elfeed
  :straight t
  :custom
  (elfeed-db-directory "~/Library/CloudStorage/Dropbox/Emacs/elfeed")
  (elfeed-show-entry-switch 'display-buffer)
  :bind
  ("C-c e" . elfeed))

;; Configure Elfeed with org mode

(use-package elfeed-org
  :straight t
  :after elfeed
  :config
  (elfeed-org)
  :custom
  (rmh-elfeed-org-files '("~/Library/CloudStorage/Dropbox/Emacs/elfeed.org")))

(use-package elfeed-webkit
  :straight t
  :after elfeed)

(use-package nov
  :straight t
  :defer t)

;; (use-package nov-xwidget
;;   :straight t
;;   :defer t
;;   :after nov
;;   :config
;;   (define-key nov-mode-map (kbd "o") 'nov-xwidget-view)
;;   (add-hook 'nov-mode-hook 'nov-xwidget-inject-all-files))


(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  
(pixel-scroll-precision-mode)

(display-time-mode)

(toggle-frame-maximized)

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
  :commands vertico-mode
  :hook (after-init . vertico-mode)
  :custom
  (vertico-count 10) 
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
         ([remap Info-search] . consult-info)
        ;; C-x bindings in `ctl-x-map'
        ;; ("C-x M-:" . consult-complex-command)
        ;; ("C-x b" . consult-buffer)
        ;; ("C-x 4 b" . consult-buffer-other-window)
        ;; ("C-x 5 b" . consult-buffer-other-frame)
        ;; ("C-x t b" . consult-buffer-other-tab)
        ;; ("C-x r b" . consult-bookmark)
        ;; ("C-x p b" . consult-project-buffer)
        ;; Custom M-# bindings for fast register access
        ("M-#" . consult-register-load)
        ("M-'" . consult-register-store)
        ("C-M-#" . consult-register)
        ;; Other custom bindings
        ("M-y" . consult-yank-pop)
        ;; M-g bindings in `goto-map'
        ;; ("M-g e" . consult-compile-error)
        ;; ("M-g f" . consult-flymake)
        ;; ("M-g g" . consult-goto-line)
        ;; ("M-g M-g" . consult-goto-line)
        ;; ("M-g o" . consult-outline)
        ;; ("M-g m" . consult-mark)
        ;; ("M-g k" . consult-global-mark)
        ;; ("M-g i" . consult-imenu)
        ;; ("M-g I" . consult-imenu-multi)
        ;; M-s bindings in `search-map'
        ;; ("M-s d" . consult-find)
        ;; ("M-s c" . consult-locate)
        ;; ("M-s g" . consult-grep)
        ;; ("M-s G" . consult-git-grep)
        ;; ("M-s r" . consult-ripgrep)
        ;; ("M-s l" . consult-line)
        ;; ("M-s L" . consult-line-multi)
        ;; ("M-s k" . consult-keep-lines)
        ;; ("M-s u" . consult-focus-lines)
        ;; Isearch integration
        ;; ("M-s e" . consult-isearch-history)
        ;; :map isearch-mode-map
        ;; ("M-e" . consult-isearch-history)
        ;; ("M-s e" . consult-isearch-history)
        ;; ("M-s l" . consult-line)
        ;; ("M-s L" . consult-line-multi)
        ;; Minibuffer history
        ;; :map minibuffer-local-map
        ;; ("M-s" . consult-history)
        ;; ("M-r" . consult-history))

        ;; xah-fly-keys map binding
        :map xah-fly-leader-key-map
        ;; ("u" . consult-buffer)
        ;; ("c c" . consult-bookmark)
        ;; ("8 u" . consult-project-buffer)

        )
 
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

(use-package xah-fly-keys
  :straight t
  :demand t
  :custom
  (xah-fly-use-control-key t)
  (xah-fly-use-meta-key t)
  ;; :hook
  ;; ((dired-mode info-mode ibuffer-mode bookmark-bmenu-mode) . xah-fly-insert-mode-activate)
  :config
  (xah-fly-keys-set-layout "dvorak")
  (xah-fly-keys 1)

  (defvar xah-major-leader-key nil "Global leader key for major modes.
Value is a string, in the same format as printed by `describe-key'.
e.g. \"TAB\" \"<f9>\" \"C-c\".")

  (when (not xah-major-leader-key)
    (setq xah-major-leader-key "TAB"))

  (defvar xah-org-leader-map nil "A keymap for all `org-mode' keybinding.")

  (define-key xah-fly-leader-key-map (kbd "8") 'nil)

  (define-key xah-fly-insert-map (kbd "C-b") 'backward-char)
  (define-key xah-fly-insert-map (kbd "C-f") 'forward-char)
  (define-key xah-fly-insert-map (kbd "C-a") 'move-beginning-of-line)
  (define-key xah-fly-insert-map (kbd "C-e") 'move-end-of-line)
  (define-key xah-fly-insert-map (kbd "C-p") 'previous-line)
  (define-key xah-fly-insert-map (kbd "C-n") 'next-line)
  (define-key xah-fly-insert-map (kbd "C-k") 'kill-line)

  
  )

;; color delimiters
(use-package rainbow-delimiters
  :straight t
  :hook (prog-mode . rainbow-delimiters-mode))

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
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  
  (setq line-spacing 0.2
        org-startup-indented t
        org-pretty-entities t
        org-use-sub-superscripts "{}"
        org-hide-emphasis-markers t
        org-startup-with-inline-images t
        org-image-actual-width '(300))

  (progn
    (define-prefix-command 'xah-org-leader-map)
    (define-key xah-org-leader-map (kbd "TAB") #'org-cycle)
    
    (define-key xah-org-leader-map (kbd ".") #'org-time-stamp)

    (define-key xah-org-leader-map (kbd "e") #'org-mac-link-get-link)
    (define-key xah-org-leader-map (kbd "o") #'denote-insert-link)
    (define-key xah-org-leader-map (kbd "a") #'denote-org-extras-link-to-heading)
    (define-key xah-org-leader-map (kbd "u") #'org-insert-link)
    
  )

  (define-key org-mode-map (kbd xah-major-leader-key) xah-org-leader-map)
)


(use-package org
  :ensure nil
  :defer t
  :after xah-fly-keys
  :bind
  ( :map xah-fly-leader-key-map
    ("8 l" . org-store-link)
    ;; to define: org-capture, org-agenda
  )
  :hook (org-mode . huegli/org-mode-setup)
  :custom-face
  (org-table ((t (:inherit fixed-pitch))))
  (org-code ((t (:inherit (shadow fixed-pitch)))))
  (org-verbatim ((t (:inherit (shadow fixed-pitch)))))
  (org-block ((t (:inherit fixed-pitch))))
  (org-special-keyword ((t (:inherit fixed-pitch))))
  (org-meta-line ((t (:inherit fixed-pitch))))
  (org-checkbox ((t (:inherit fixed-pitch))))
  ;; (set-face-attribute 'org-code nil :inherit 'fixed-pitch)
  :config
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

(use-package org-mac-link
  :after org
  :straight t)

(use-package org-modern
  :straight t
  :config
  (global-org-modern-mode t))

;; Configure project.el's root markers
(defcustom project-root-markers
  '("compile_commands.json" "compile_flags.txt" ".project" ".git")
  "Files or directories that indicate the root of a project."
  :type '(repeat string)
  :group 'project)

(defun project-root-p (path)
  "Check if the current PATH has any of the project root markers."
  (catch 'found
    (dolist (marker project-root-markers)
      (when (file-exists-p (concat path marker))
        (throw 'found marker)))))


(defun project-find-root (path)
  "Search up the PATH for `project-root-markers'."
  (let ((path (expand-file-name path)))
    (catch 'found
      (while (not (equal "/" path))
        (if (not (project-root-p path))
            (setq path (file-name-directory (directory-file-name path)))
          (throw 'found (cons 'transient path)))))))

(use-package project
  :ensure nil  
  :config
  (add-to-list 'project-find-functions #'project-find-root))

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
  :defer t
  :bind (

          :map bookmark-bmenu-mode-map
              ("C-o" . #'casual-bookmarks-tmenu)
              ("J" . #'bookmark-jump)


          :map calendar-mode-map
              ("C-o" . #'casual-calendar-tmenu)
          
          :map Info-mode-map
              ("C-o" . #'casual-info-tmenu)))

(use-package denote
  :straight t
  :commands (denote-directory)
  :after xah-fly-keys
  :bind
  ( :map dired-mode-map
    ("C-c C-d C-r" . denote-dired-rename-files)
    :map xah-fly-leader-key-map
    ("8 e" . denote-open-or-create)
    ("8 t" . denote-journal-extras-new-or-existing-entry))
  
  :custom
  ((denote-directory "~/Library/CloudStorage/Dropbox/Denote")
   (denote-file-type 'org)
   (denote-known-keywords '("emacs" "macosx" "stephanie" "mikhaila" "sandiego" "financials" "programing"))
   (denote-date-prompt-use-org-read-date t)
   (denote-journal-extras-title-format 'day-date-month-year)
   (denote-dired-directories-include-subdirectories t))
  )

(use-package consult-denote
  :straight t
  :after denote
  :bind
  ( :map global-map
    ("C-c n f" . consult-denote-find)
    ("C-c n g" . consult-denote-grep)
    )
  :config
  (consult-denote-mode t))

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
  :after elfeed
  :bind (:map elfeed-show-mode-map
              ("%" . elfeed-webkit-toggle)))

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

(use-package spacious-padding
  :straight t
  :if (display-graphic-p)
  :config
  (spacious-padding-mode t))

(use-package slime
  :straight t
  :config
  (setq inferior-lisp-program "/opt/homebrew/bin/sbcl"))

(use-package emacs
  :ensure nil
  :config
  (setq completion-auto-select 'second-tab)
  )

(use-package dired
  :straight nil
  :ensure nil
  :bind (
         :map dired-mode-map
              ("C-o" . #'casual-dired-tmenu)
              ("s" . #'casual-dired-sort-by-tmenu)
              ("/" . #'casual-dired-search-replace-tmenu))
  :config
  (setq dired-dwim-target t)
  (setq denote-dired-directories
        '("~/Library/CloudStorage/Dropbox/Denote"
          "~/Library/CloudStorage/Dropbox/Statements 2024"
          "~/Desktop"
          "~/Downloads"))
  (add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)
  ;; (add-hook 'dired-mode-hook #'denote-dired-mode)
  )

(use-package ibuffer
  :straight nil
  :ensure nil
  :bind (
         :map ibuffer-mode-map
              ("C-o" . #'casual-ibuffer-tmenu)
              ("F" . #'casual-ibuffer-filter-tmenu)
              ("s" . #'casual-ibuffer-sortby-tmenu)))

(use-package winner-mode
  :straight nil
  :ensure nil
  :bind (
         :map xah-fly-leader-key-map
              ("8 w" . winner-undo)))
 
(pixel-scroll-precision-mode)

(display-time-mode)

(repeat-mode t)

(winner-mode t)

(toggle-frame-maximized)

;;; Load custom.el
(minimal-emacs-load-user-init "custom.el")

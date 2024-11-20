;;; FILENAME.el --- DESCRIPTION -*- no-byte-compile: t; lexical-binding: t; -*-

(defun my/apply-theme (appearance)
  "Load theme, taking current system APPEARANCE into consideration."
  (mapc #'disable-theme custom-enabled-themes)
  (pcase appearance
    ('light (load-theme 'modus-operandi t))
    ('dark (load-theme 'modus-vivendi t))))

(add-hook 'ns-system-appearance-change-functions #'my/apply-theme)

(set-face-attribute 'default nil :family "Iosevka Curly" :height 180 :weight 'medium)
(set-face-attribute 'fixed-pitch nil :family "Iosevka Curly" :height 180)
(set-face-attribute 'variable-pitch nil :family "Iosevka Etoile" :height 180 :weight 'light)

;; (set-face-attribute 'default nil :family "VictorMono Nerd Font" :height 180)
;; (set-face-attribute 'fixed-pitch nil :font "VictorMono Nerd Font" :height 180)
;; (set-face-attribute 'variable-pitch nil :font "Atkinson Hyperlegible" :height 180)



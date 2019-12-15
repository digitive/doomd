;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq display-line-numbers-type 'relative)

(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold nil    ; if nil, bold is universally disabled
      doom-themes-enable-italic nil) ; if nil, italics is universally disabled
(setq doom-font (font-spec :family "MesloLGS NF" :size 14))

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
(load-theme 'doom-one t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)
;; or for treemacs users
(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)
(setq projectile-project-search-path '("~/src"))
(setq doom-themes-treemacs-enable-variable-pitch nil)

(global-set-key (kbd "<f9>") 'next-buffer)
(global-set-key (kbd "<f10>") 'previous-buffer)
(custom-set-variables
  '(helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
  '(helm-ag-insert-at-point 'word)
)

(global-set-key (kbd "C-<f2>") 'helm-ag)
(setq dired-dwim-target t)

(def-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-super-agenda-groups '((:name "Today"
                                         :time-grid t
                                         :scheduled today)
                                  (:name "Due today"
                                         :deadline today)
                                  (:name "Important"
                                         :priority "A")
                                  (:name "Over due"
                                         :deadline past)
                                  (:name "Due soon"
                                         :deadline future)
                                  (:name "Big Outcomes"
                                         :tag "bo")))
  :config
  (org-super-agenda-mode)
)

(setq company-idle-delay 0.2
      company-minimum-prefix-length 3)


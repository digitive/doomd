;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "James Zhang"
      user-mail-address "james.zhang@staff.atmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)

(setq doom-themes-enable-bold nil    ; if nil, bold is universally disabled
      doom-themes-enable-italic nil) ; if nil, italics is universally disabled
(setq doom-font (font-spec :family "MesloLGS NF" :size 14))

(set-fringe-mode 15)
(setq confirm-kill-emacs nil)

(defun insert-current-date () (interactive)
       (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))

(after! evil
  (setq evil-disable-insert-state-bindings t)
  (define-key evil-insert-state-map (kbd "C-c d") 'insert-current-date)
  (define-key evil-insert-state-map (kbd "C-c v") 'put-ticket-no))

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

(global-set-key (kbd "M-n") 'helm-ag-project-root)
(setq dired-dwim-target t)

(setq company-idle-delay 0.2
      company-minimum-prefix-length 3)

;; Golang compile
(defun my-go-mode-hook()
  (setq compilation-read-command nil)
  (setq compile-command "go build && go test && go test")
  (setq projectile-project-compilation-cmd "go install ./cmd/...")
  (local-set-key (kbd "s-b") 'projectile-compile-project)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)
(put 'narrow-to-region 'disabled nil)

(dap-mode 1)
;; The modes below are optional
(dap-ui-mode 1)
;; enables mouse hover support
(dap-tooltip-mode 1)
;; use tooltips for mouse hover
;; if it is not enabled `dap-mode' will use the minibuffer.
(tooltip-mode 1)
;; displays floating panel with debug buttons
;; requies emacs 26+
(dap-ui-controls-mode 1)

(require 'dap-go)

(after! go-mode
  (setq gofmt-command "goimports")
  (add-hook 'go-mode-hook
            (lambda ()
              (add-hook 'after-save-hook 'gofmt nil 'make-it-local))))

(defun put-ticket-no ()
  (interactive)
  (insert (shell-command-to-string "curticket")))

(global-set-key
  (kbd "C-c C-v")
  'put-ticket-no
  )

;;Exit insert mode by pressing j and then j quickly
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)


(evil-global-set-key 'insert (kbd "C-c C-d") 'insert-current-date)

;; visualization settings
(menu-bar-mode -1) ;; hide menu bar
(scroll-bar-mode -1) ;; hide scroll bar
(tool-bar-mode -1) ;; hide tool bar
(global-visual-line-mode) ;; globally activate visual line mode

(setq inhibit-startup-screen t) ;; inhibit startup screen

;; setup fonts 
(set-face-attribute 'default nil :font "Fira Code 12") ;default font fira code
(set-face-attribute 'fixed-pitch nil :font "Fira Code 12") ;fixed pitch fira code
(set-face-attribute 'variable-pitch nil :font "CMU Sans Serif 14") ;variable pitch computer modern

;; locate different file custom-vars.el for custom set variables 
(setq custom-file "~/.emacs.d/custom-vars.el")
(load custom-file )

; enable melpa 
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use package declaration
(eval-when-compile
  (require 'use-package))

;; magit
(use-package magit
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; VI key-bindings
(use-package evil
  :ensure t
  :init
    (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init 'dired))


;; general.el for keybinding management
(use-package general
  :ensure t
  :config
  (general-create-definer Niraj/leader-keys
			  :keymaps '(normal insert visual emacs)
			  :prefix "SPC"
			  :global-prefix "C-SPC"))
;; key mappings

;; global mappings 
(Niraj/leader-keys
  ;; buffers 
  "bw" 'save-buffer
  "bs" 'switch-to-buffer
  "bl" 'list-buffers
  "be" 'eval-buffer

  "dr"  'dired
  ;; org-mode key bindings 
  "oa"  'org-agenda
  ;; editing text
  "ec" 'comment-region
  "eu" 'uncomment-region)

;; org-mode mappings
(Niraj/leader-keys
  :keymap 'org-mode-map
  "ll" 'org-latex-preview)

;; locate your init file
(defun my-init-file()
     (interactive)			
     (find-file "~/.emacs.d/init.el"))

(Niraj/leader-keys
  ;; init-file 
  "in" 'my-init-file)
;; locate your init file

;; auctex settings
(use-package tex
  :ensure auctex
  :pin gnu
  :hook ((LaTeX-mode . prettify-symbols-mode)))

;; cdlatex settings
(use-package cdlatex
  :ensure t
  :hook (LaTeX-mode . turn-on-cdlatex))


;; copied 
;; Yasnippet settings
(use-package yasnippet
  :ensure t
  :hook ((LaTeX-mode . yas-minor-mode)
         (post-self-insert . my/yas-try-expanding-auto-snippets))
  :config
    (setq yas-snippet-dirs '("~/repositories/yasnippets"))
  (use-package warnings
    :config
    (cl-pushnew '(yasnippet backquote-change)
                warning-suppress-types
                :test 'equal))

  (setq yas-triggers-in-field t)
  
  ;; Function that tries to autoexpand YaSnippets
  ;; The double quoting is NOT a typo!
  (defun my/yas-try-expanding-auto-snippets ()
    (when (and (boundp 'yas-minor-mode) yas-minor-mode)
      (let ((yas-buffer-local-condition ''(require-snippet-condition . auto)))
        (yas-expand)))));; yasnippet settings

(use-package preview
  :after latex
  :hook ((LaTeX-mode . preview-larger-previews))
  :config
  (defun preview-larger-previews ()
    (setq preview-scale-function
          (lambda () (* 2.50
                   (funcall (preview-scale-from-face)))))))

(use-package denote
  :ensure t
  :config
  (setq denote-directory (expand-file-name "~/notes/")))

;; load org-mode configuration
(load "~/.emacs.d/niraj/org-mode.el")

;; load packages auto activating snippets  and latex auto activating snippets
(load "~/.emacs.d/niraj/auto-snippets-system.el")

;; load vertico savehist orderless for completion
(load "~/.emacs.d/niraj/completion.el")  

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package org-modern
  :ensure t)

(use-package pdf-tools
  :ensure t)

;; load theme_settings 
(load "~/.emacs.d/niraj/theme-launcher.el")

(use-package mixed-pitch
  :ensure t)

(load "~/.emacs.d/niraj/read-write.el")

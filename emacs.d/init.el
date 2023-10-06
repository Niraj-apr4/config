;; visualization settings
(menu-bar-mode -1) ;; hide menu bar
(scroll-bar-mode -1) ;; hide scroll bar
(tool-bar-mode -1) ;; hide tool bar

(setq inhibit-startup-screen t) ;; inhibit startup screen

;; (set-frame-font "Fira Code 12" nil t) ;; set up font 
(set-face-attribute 'default nil :font "Fira Code 12")
(set-face-attribute 'fixed-pitch nil :font "Fira Code 12")
(set-face-attribute 'variable-pitch nil :font "CMU Concrete")

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

;;copied
; (use-package ef-themes 
;   :ensure t
;   :config
;   (load-theme 'ef-maris-light t))
;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   (load-theme 'doom-nord-aurora t))

(use-package denote
  :ensure t
  :config
  (setq denote-directory (expand-file-name "~/notes/")))

(use-package org
  :config
  (setq org-log-done 'time)
  (setq org-todo-keywords
	'((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE" "CANCELLED")))
  (setq org-return-follows-link t)
  (setq org-highlight-latex-and-related '(latex script entities))
    ;; active Babel languages
    (org-babel-do-load-languages
    'org-babel-load-languages
    '((shell . t))))



(use-package aas
  :ensure t
  :hook (LaTeX-mode . aas-activate-for-major-mode)
  :hook (org-mode . aas-activate-for-major-mode)
  :config
  (aas-set-snippets 'text-mode
    ;; expand unconditionally
    ";o-" "ō"
    ";i-" "ī"
    ";a-" "ā"
    ";u-" "ū"
    ";e-" "ē")
  (aas-set-snippets 'latex-mode
    ;; set condition!
    :cond #'texmathp ; expand only while in math
    "supp" "\\supp"
    "On" "O(n)"
    "O1" "O(1)"
    "Olog" "O(\\log n)"
    "Olon" "O(n \\log n)"
    ;; Use YAS/Tempel snippets with ease!
    "amin" '(yas "\\argmin_{$1}") ; YASnippet snippet shorthand form
    "amax" '(tempel "\\argmax_{" p "}") ; Tempel snippet shorthand form
    ;; bind to functions!
    ";ig" #'insert-register
    ";call-sin"
    (lambda (angle) ; Get as fancy as you like
      (interactive "sAngle: ")
      (insert (format "%s" (sin (string-to-number angle))))))
  ;; disable snippets by redefining them with a nil expansion
  (aas-set-snippets 'latex-mode
    "supp" nil))

(use-package laas
  :ensure t
  :hook (LaTeX-mode . laas-mode)
  :config ; do whatever here
  (aas-set-snippets 'laas-mode
		    "(" (lambda () (interactive)
			(yas-expand-snippet "($1)$0"))
		    "[" (lambda () (interactive)
			(yas-expand-snippet "[$1]$0"))
		    "{" (lambda () (interactive)
			(yas-expand-snippet "{$1}$0"))
                    ;; set condition!
                    :cond #'texmathp ; expand only while in math
		    "dd" "+"
		    "ss" "-"
		    "ee" "="
                    "supp" "\\supp"
                    "On" "O(n)"
                    "O1" "O(1)"
                    "Olog" "O(\\log n)"
                    "Olon" "O(n \\log n)"
                    ;; bind to functions!
                    "Sum" (lambda () (interactive)
                            (yas-expand-snippet "\\sum_{$1}^{$2} $0"))
                    "Span" (lambda () (interactive)
                             (yas-expand-snippet "\\Span($1)$0"))
                    ;; add accent snippets
                    :cond #'laas-object-on-left-condition
                    "qq" (lambda () (interactive) (laas-wrap-previous-object "sqrt"))))

;;  >>> problem with org toggle pretty entites
(add-hook 'cdlatex-mode-hook
 (lambda () (when (eq major-mode 'org-mode)
  (make-local-variable 'org-pretty-entities-include-sub-superscripts)
   (setq org-pretty-entities-include-sub-superscripts nil))))
;;  <<< problem with org toggle pretty entites

;; >>> enlarge org latex preview
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
;; <<< enlarge org latex preview

(use-package pdf-tools
  :ensure t)
  
;; Enable vertico
(use-package vertico
  :ensure t
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))


;; Optionally use the `orderless' completion style.
(use-package orderless
  :ensure t
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package org-modern
  :ensure t)

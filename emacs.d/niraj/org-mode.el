(use-package org
  :config
  (setq org-agenda-files '("~/tasks"))
  (setq org-pretty-entities t
	org-hide-emphasis-markers t)
  (setq org-log-done 'time) ;; records done time 
  ;; customize workflow states 
  (setq org-todo-keywords
	'((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE" "CANCELLED")))
  (setq org-return-follows-link t)
  (setq org-highlight-latex-and-related '(latex script entities))

  ;; org Babel ;;;;;;;;
  ;; active Babel languages
  (org-babel-do-load-languages 'org-babel-load-languages '((shell . t)
			                                   (python . t)
							   ))
  (setq org-babel-python-command "/home/niraj/micromamba/envs/pythonEnv/bin/python3")
  (setq org-src-fontify-natively t
    org-src-tab-acts-natively t)
  ;; org Babel ;;;;;;;;;
							   
    ;; enlarge org latex preview
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5)))
  

;;  >>> problem with org toggle pretty entites
(add-hook 'cdlatex-mode-hook
 (lambda () (when (eq major-mode 'org-mode)
  (make-local-variable 'org-pretty-entities-include-sub-superscripts)
   (setq org-pretty-entities-include-sub-superscripts nil))))
;;  <<< problem with org toggle pretty entites

;; babel

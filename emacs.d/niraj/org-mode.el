(use-package org
  :config
  (setq org-format-latex-options (plist-put org-format-latex-options :justify 'center))
  (setq org-log-done 'time) ;; records done time 
  ;; customize workflow states 
  (setq org-todo-keywords
	'((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE" "CANCELLED")))
  (setq org-return-follows-link t)
  (setq org-highlight-latex-and-related '(latex script entities))
    ;; active Babel languages
    (org-babel-do-load-languages
    'org-babel-load-languages
    '((shell . t)))
    ;; enlarge org latex preview
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5)))

;;  >>> problem with org toggle pretty entites
(add-hook 'cdlatex-mode-hook
 (lambda () (when (eq major-mode 'org-mode)
  (make-local-variable 'org-pretty-entities-include-sub-superscripts)
   (setq org-pretty-entities-include-sub-superscripts nil))))
;;  <<< problem with org toggle pretty entites

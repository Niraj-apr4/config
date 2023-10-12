(defvar niraj/big-fringe-mode nil)
(define-minor-mode niraj/big-fringe-mode
  "Minor mode to use big fringe in the current buffer."
  :init-value nil
  :global t
  :variable niraj/big-fringe-mode
  :group 'editing-basics
  (if (not niraj/big-fringe-mode)
      (set-fringe-style nil)
    (set-fringe-mode
     (/ (- (frame-pixel-width)
           (* 100 (frame-char-width)))
        2))))

(defvar read-write-mode-state -1)
(defun niraj/read-write-mode (state)
  ;; enable fringe mode
  (niraj/big-fringe-mode 1)
  ;; enable  mixed-pitch-mode 
  (setq mixed-pitch-set-height 1)
  (mixed-pitch-mode state)
  ;; enable org-modern-mode
  (org-modern-mode state)
  ;; enable autofill-mode for text support
  (auto-fill-mode state)
  (set-fill-column 125)
  ;; enable snippets support
  (yas-minor-mode state)
  (yas-reload-all state)
  (cdlatex-mode state)
  (laas-mode state))
  ;; hide mode line


;; interactive function to toggle read-write-mode
(defun niraj/switch-read-write-mode()
  (interactive)
  (cond
    ((= read-write-mode-state 1) (setq read-write-mode-state -1))
    ((= read-write-mode-state -1) (setq read-write-mode-state 1))
    (t (setq read-write-mode-state -1)))
  (niraj/read-write-mode read-write-mode-state))

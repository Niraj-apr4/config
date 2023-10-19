(setq *lightTheme 'whiteboard) ;; set light theme
(setq *darkTheme  'deeper-blue) ;; set dark theme


(defun niraj/toggle-theme()
  (interactive)
  ;; get current theme
  (let ((*currentTheme (car custom-enabled-themes))) ;get current theme
       ;;disable current theme
       (disable-theme *currentTheme)
       (cond
	   ;;enable light theme if current theme is  dark 
           (  (eq *currentTheme *lightTheme) (load-theme *darkTheme)) 
	   ;; enable dark theme if  curent theme is  light
           (  (eq *currentTheme *darkTheme) (load-theme *lightTheme))
	   ;; else enable light as  default
           (t (load-theme       *lightTheme))))
 (my-tone-down-fringes))
  

(defun my-tone-down-fringes ()
  (set-face-attribute 'fringe nil
                      :foreground (face-foreground 'default)
                      :background (face-background 'default)))

(my-tone-down-fringes)

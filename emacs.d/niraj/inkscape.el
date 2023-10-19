(defun niraj/abs-img-name(img-name)
;; generates absolute path of img-name
;; assumes that images files for corresponding org files
;; are stored in ~/path to org files/orgfiles.org/img/..
;; this function generated full absolute path of image with name img-name 
  (concat (file-name-directory buffer-file-name) "img/" img-name))

;; tests of niraj/abs-img-name
  

(defun niraj/get-input()
  (let ((img-name (read-from-minibuffer "Enter image name: ")) ; get img-name from user
        (img-caption (read-from-minibuffer "Enter caption: "))) ; get img-caption from user
        (insert (concat "#+CAPTION: " img-caption "\n" )) ; insert caption
	(insert (concat "[[./img/" img-name ".svg" "]]" )) ; insert img
	( (abs-img (niraj/abs-img-name img-name)) ) ; gen full path of img and store in abs-img
	(message abs-img)
	;; tests for above code
	))

;; (call-process-shell-command (concat "cp " img-client " " (niraj/gen-img-name *img-name)))
;; (call-process-shell-command (concat "inkscape "(niraj/gen-img-name *img-name) ))

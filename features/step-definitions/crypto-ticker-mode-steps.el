;; This file contains your project specific step definitions. All
;; files in this directory whose names end with "-steps.el" will be
;; loaded automatically by Ecukes.

(Then "^the mode line should contain \"\\([^\"]+\\)\"$"
  (lambda (text)
    (cl-assert (member text global-mode-string) nil "Mode line did not contain text")))


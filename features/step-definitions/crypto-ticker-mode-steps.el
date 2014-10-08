;; This file contains your project specific step definitions. All
;; files in this directory whose names end with "-steps.el" will be
;; loaded automatically by Ecukes.

(Then "^the mode line should contain \"\\([^\"]+\\)\"$"
  (lambda (variable)
    (cl-assert (member (intern variable) global-mode-string) nil
               (format "Mode line did not contain the variable: %s" variable))))

(Then "^the mode line should not contain \"\\([^\"]+\\)\"$"
  (lambda (variable)
    (cl-assert (not (member (intern variable) global-mode-string)) nil "Mode line contained the variable")))

(When "^I turn off \\(.+\\)$"
  "Turns off some mode."
  (lambda (mode)
    (let ((v (vconcat [?\C-u 1 ?\M-x] (string-to-vector mode))))
      (execute-kbd-macro v))))

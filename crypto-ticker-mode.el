;;; crypto-ticker-mode.el --- Shows the latest crypto currency prices

;; Based on btc-ticker by Jorge Niedbalski R.

;; Copyright (C) 2014 Phil Newton

;; Author: Phil Newton <phil@sodaware.net>
;; Version: 0.1
;; Package-Requires: ((cryptsy-public-api "0.1"))
;; Keywords: dogecoin bitcoin litecoin

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This mode fetches the latest exchange rates for various crypto currencies and
;; displays them in the mode line.  It can be configured to show different
;; currencies, and supports a variety of backends.

;; At the moment it just uses Cryptsy, but over time I'll be adding more
;; backends.

;;; Code:

;; Dependencies

;; (require 'crypto-ticker-mode-driver-cryptsy)

;; Configuration

(defconst crypto-ticker-mode-format " %s %s%s/%s")

(defgroup crypto-ticker-mode nil
  "crypto-ticker-mode extension"
  :group 'comms
  :prefix "crypto-ticker-mode-")

(defcustom crypto-ticker-mode-api-poll-interval 600
  "API polling interval in seconds."
  :type 'number
  :group 'crypto-ticker-mode)

(defvar crypto-ticker-mode-driver 'crypto-ticker-mode-driver-cryptsy)

(defvar crypto-ticker-mode-timer nil
  "API polling timer.")

(defvar crypto-ticker-mode-modeline-text "---"
  "Text to display on the mode line.")

(defvar crypto-ticker-mode-symbol-increased "↑"
  "Text to display when new price is higher than the previous one.")

(defvar crypto-ticker-mode-symbol-decreased "↓"
  "Text to display when new price is lower than the previous one.")

(defvar crypto-ticker-mode-symbol-same "-"
  "Text to display when new price is the same as the previous one.")

(defvar crypto-ticker-mode-current-value 0)
(defvar crypto-ticker-mode-previous-value 0)

(defvar crypto-ticker-mode-currency-from-symbol "Ð"
  "The symbol for the base currency.")

(defvar crypto-ticker-mode-currency-to-symbol "$"
  "The symbol for the converted currency.")

;; Add to the modeline
(put 'crypto-ticker-mode-modeline-text 'risky-local-variable t)


;; Main code

(defun crypto-ticker-mode-start ()
  "Start the update timer and add ."
  (unless crypto-ticker-mode-timer
    (setq global-mode-string (append global-mode-string 'crypto-ticker-mode-modeline-text))
    (setq crypto-ticker-mode-timer
          (run-at-time "0 sec"
                       crypto-ticker-mode-api-poll-interval
                       #'crypto-ticker-mode--refresh))))

(defun crypto-ticker-mode-stop ()
  "Stop the update timer and clean up the mode line."
  (when crypto-ticker-mode-timer
    (cancel-timer crypto-ticker-mode-timer)
    (setq crypto-ticker-mode-timer nil)
    (setq global-mode-string
          (delq 'crypto-ticker-mode-modeline-text global-mode-string))))

(defun crypto-ticker-mode-update-status ()
  "Fetch the latest value from the driver and update the status mode line."
  (interactive)
  (if (crypto-ticker-mode--valid-driver-p crypto-ticker-mode-driver)
      (progn
        (setq crypto-ticker-mode-previous-value crypto-ticker-mode-current-value)
        (setq crypto-ticker-mode-current-value (funcall crypto-ticker-mode-driver))
        (setq crypto-ticker-mode-modeline-text (crypto-ticker-mode--format-mode-line)))
    (error "Invalid driver specified")))


;; Internal helpers

(defun crypto-ticker-mode--refresh ()
  "Fetch the result from the backend and update the modeline."
  (crypto-ticker-mode-update-status)
  (force-mode-line-update))

(defun crypto-ticker-mode--get-difference-symbol (current previous)
  "Get the difference symbol to display for CURRENT and PREVIOUS."
  (cond
   ((< current previous) crypto-ticker-mode-symbol-decreased)
   ((> current previous) crypto-ticker-mode-symbol-increased)
   ((= current previous) crypto-ticker-mode-symbol-same)))

(defun crypto-ticker-mode--format-mode-line ()
  "Formats the mode line based on the current data."
  (let ((difference-symbol (crypto-ticker-mode--get-difference-symbol
                            crypto-ticker-mode-current-value
                            crypto-ticker-mode-previous-value)))
    (format crypto-ticker-mode-format
            difference-symbol
            crypto-ticker-mode-current-value
            crypto-ticker-mode-currency-from-symbol
            crypto-ticker-mode-currency-to-symbol)))

(defun crypto-ticker-mode--valid-driver-p (driver)
  "Check if the DRIVER is valid."
  (not (null driver)))


;;;###autoload
(define-minor-mode crypto-ticker-mode
  "Minor mode to display latest crypto currency prices."
  :init-value nil
  :global t
  (if (null crypto-ticker-mode-timer)
      (crypto-ticker-mode-start)
    (crypto-ticker-mode-stop)))

(provide 'crypto-ticker-mode)
;;; crypto-ticker-mode.el ends here

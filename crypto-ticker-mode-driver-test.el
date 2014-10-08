;;; crypto-ticker-mode-driver-test.el --- Test driver

;; Based on btc-ticker by Jorge Niedbalski R.
;; Copyright (C) 2014 Phil Newton

;; Author: Phil Newton <phil@sodaware.net>

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

;; Acts as a dummy backend for crypto-ticker-mode.that can be used during
;; testing as it doesn't connect to any API.

;;; Code:

;; Dependencies

;; Driver functions

(defvar crypto-ticker-mode-driver-test-current-value 0
  "Value to return from 'get-value'.")

(defun crypto-ticker-mode-driver-test ()
  "Get the current test value."
  crypto-ticker-mode-driver-test-current-value)


(provide 'crypto-ticker-mode-driver-test)
;;; crypto-ticker-mode-driver-test ends here

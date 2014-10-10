;;; crypto-ticker-mode-driver-cryptsy.el --- Driver for Cryptsy

;; Based on btc-ticker by Jorge Niedbalski R.;; Copyright (C) 2014 Phil Newton

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

;; Adds Cryptsy as a backend for crypto-ticker-mode

;;; Code:

;; Dependencies
(require 'cryptsy-public-api)

;; Configuration
(defvar crypto-ticker-mode-driver-cryptsy-market-id 182)

(defun crypto-ticker-mode-driver-cryptsy ()
  "Get the latest exchange rate from cryptsy."
  (let* ((response (cryptsy-public-api-get-market-data crypto-ticker-mode-driver-cryptsy-market-id))
         (market-name (crypto-ticker-mode-driver-cryptsy--get-currency-symbol response)))
    (string-to-number  (cryptsy-public-api-get-info-value
                        market-name
                        'lasttradeprice
                        response))))

(defun crypto-ticker-mode-driver-cryptsy--get-currency-symbol (response)
  "Get the currency symbol from RESPONSE."
  (caar  (assoc-default 'markets (assoc-default 'return response))))

(provide 'crypto-ticker-mode-driver-cryptsy)
;;; crypto-ticker-mode-driver-cryptsy ends here

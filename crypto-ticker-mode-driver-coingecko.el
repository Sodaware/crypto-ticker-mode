;;; crypto-ticker-mode-driver-coingecko.el --- Driver for CoinGecko

;; Based on btc-ticker by Jorge Niedbalski R.
;; Copyright (C) 2014-2019 Phil Newton

;; Author: Phil Newton <phil@sodaware.net>
;; Version: 0.1.1
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

;; Add CoinGecko as a backend for crypto-ticker-mode

;;; Code:

;; Dependencies
(require 'json)
(require 'url-http)

(defvar url-http-end-of-headers)

;; Configuration

(defcustom crypto-ticker-mode-driver-coingecko-from-currency "dogecoin"
  "The CoinGecko currency symbol to convert from."
  :type 'number
  :group 'crypto-ticker-mode)

(defcustom crypto-ticker-mode-driver-coingecko-to-currency "usd"
  "The CoinGecko currency symbol to convert from."
  :type 'number
  :group 'crypto-ticker-mode)


;; Main driver function

(defun crypto-ticker-mode-driver-coingecko ()
  "Get the latest exchange rate from CoinGecko."
  ;; Get the latest value from CoinGecko.
  (crypto-ticker-mode-driver-coingecko--fetch-exchange-rate
   crypto-ticker-mode-driver-coingecko-from-currency
   crypto-ticker-mode-driver-coingecko-to-currency))

;; Internal Helpers

(defun crypto-ticker-mode-driver-coingecko--fetch-exchange-rate (from-coin to-coin)
  "Get the exchange rate between FROM-COIN and TO-COIN."
  (let ((response (crypto-ticker-mode-driver-coingecko--fetch-simple-price from-coin to-coin)))
    (assoc-default (intern to-coin) (assoc-default (intern from-coin) response))))

(defun crypto-ticker-mode-driver-coingecko--fetch-simple-price (from-coin to-coin)
  "Fetch the rate for FROM-COIN to TO-COIN using the simple api."
  (let* ((url (format "https://api.coingecko.com/api/v3/simple/price?ids=%s&amp;vs_currencies=%s"
                      from-coin
                      to-coin)))
    (with-current-buffer (url-retrieve-synchronously url)
      (goto-char (point-min))
      (goto-char url-http-end-of-headers)
      (prog1 (json-read)
        (kill-buffer)))))

(provide 'crypto-ticker-mode-driver-coingecko)
;;; crypto-ticker-mode-driver-coingecko ends here

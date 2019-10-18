(add-to-list 'load-path (file-name-directory (directory-file-name (file-name-directory load-file-name))))
(require 'crypto-ticker-mode-driver-coingecko)

(ert-deftest crypto-ticker-mode-driver-coingecko-test/can-use-coingecko-as-driver ()
  (with-mock
   (mock (crypto-ticker-mode-driver-coingecko--fetch-simple-price "dogecoin" "usd") => (read-fixture "simple-price--dogecoin-vs-usd.json"))
   (let ((crypto-ticker-mode-driver 'crypto-ticker-mode-driver-coingecko)
         (crypto-ticker-mode-current-value 0))
     (crypto-ticker-mode-update-status)
     (should (string= " ↑ 0.00269239Ð/$" crypto-ticker-mode-modeline-text)))))

(ert-deftest crypto-ticker-mode-driver-coingecko-test/can-configure-currency ()
  (with-mock
   (mock (crypto-ticker-mode-driver-coingecko--fetch-simple-price "bitcoin" "gbp") => (read-fixture "simple-price--bitcoin-vs-gbp.json"))
   (let* ((crypto-ticker-mode-driver-coingecko-from-currency "bitcoin")
          (crypto-ticker-mode-driver-coingecko-to-currency "gbp")
          (exchange-rate (crypto-ticker-mode-driver-coingecko)))     
     (should (= 6145.51 exchange-rate)))))

(ert-deftest crypto-ticker-mode-driver-coingecko-test/can-fetch-simple-price ()
  (with-mock
   (mock (crypto-ticker-mode-driver-coingecko--fetch-simple-price "dogecoin" "usd") => (read-fixture "simple-price--dogecoin-vs-usd.json"))
   (let ((response (crypto-ticker-mode-driver-coingecko--fetch-simple-price "dogecoin" "usd")))
     (should (equal '((dogecoin (usd . 0.00269239))) response)))))

(add-to-list 'load-path (file-name-directory (directory-file-name (file-name-directory load-file-name))))
(require 'crypto-ticker-mode-driver-cryptsy)

(ert-deftest crypto-ticker-mode-driver-cryptsy-test/can-use-cryptsy-as-driver ()
  (with-mock
   (mock (cryptsy-public-api-get-market-data 182) => (read-fixture "singlemarketdata-marketid-182.json"))
   (let ((crypto-ticker-mode-driver 'crypto-ticker-mode-driver-cryptsy))
     (crypto-ticker-mode-update-status)
     (should (string= " ↑ 0.00038276Ð/$" crypto-ticker-mode-modeline-text)))))

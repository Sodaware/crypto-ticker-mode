
(ert-deftest crypto-ticker-mode/test-update-fails-with-invalid-driver ()
  (let ((crypto-ticker-mode-driver nil))
    (should-error (crypto-ticker-mode-update-status))))

(ert-deftest crypto-ticker-mode/test-nil-is-invalid-driver ()
  (should (null (crypto-ticker-mode--valid-driver-p nil))))

(ert-deftest crypto-ticker-mode/test-lambda-is-valid-driver ()
  (let ((crypto-ticker-mode-driver (lambda () "value")))
    (should (crypto-ticker-mode--valid-driver-p crypto-ticker-mode-driver))))

(ert-deftest crypto-ticker-mode/test-can-use-lambda-as-driver ()
  (let ((crypto-ticker-mode-driver (lambda () "value")))
    (crypto-ticker-mode-update-status)
    (should (string= "value" crypto-ticker-mode-modeline-text))))

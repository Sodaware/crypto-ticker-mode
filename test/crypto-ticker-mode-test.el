
(ert-deftest crypto-ticker-mode-test/test-update-fails-with-invalid-driver ()
  (let ((crypto-ticker-mode-driver nil))
    (should-error (crypto-ticker-mode-update-status))))

(ert-deftest crypto-ticker-mode-test/test-nil-is-invalid-driver ()
  (should (null (crypto-ticker-mode--valid-driver-p nil))))

(ert-deftest crypto-ticker-mode-test/test-lambda-is-valid-driver ()
  (let ((crypto-ticker-mode-driver (lambda () "value")))
    (should (crypto-ticker-mode--valid-driver-p crypto-ticker-mode-driver))))

(ert-deftest crypto-ticker-mode-test/test-can-use-lambda-as-driver ()
  (let ((crypto-ticker-mode-driver (lambda () "value")))
    (crypto-ticker-mode-update-status)
    (should (string= "value" crypto-ticker-mode-modeline-text))))

(ert-deftest crypto-ticker-mode-test/test-returns-correct-difference-symbol ()
  (should (string= crypto-ticker-mode-symbol-same (crypto-ticker-mode--get-difference-symbol 0 0)))
  (should (string= crypto-ticker-mode-symbol-increased (crypto-ticker-mode--get-difference-symbol 1 0)))
  (should (string= crypto-ticker-mode-symbol-decreased (crypto-ticker-mode--get-difference-symbol 0 1))))

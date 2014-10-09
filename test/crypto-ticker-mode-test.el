
(ert-deftest crypto-ticker-mode-test/test-update-fails-with-invalid-driver ()
  (let ((crypto-ticker-mode-driver nil))
    (should-error (crypto-ticker-mode-update-status))))

(ert-deftest crypto-ticker-mode-test/test-nil-is-invalid-driver ()
  (should (null (crypto-ticker-mode--valid-driver-p nil))))

(ert-deftest crypto-ticker-mode-test/test-lambda-is-valid-driver ()
  (let ((crypto-ticker-mode-driver (lambda () "value")))
    (should (crypto-ticker-mode--valid-driver-p crypto-ticker-mode-driver))))

(ert-deftest crypto-ticker-mode-test/test-can-use-lambda-as-driver ()
  (let ((crypto-ticker-mode-driver (lambda () 0))
        (crypto-ticker-mode-previous-value 0)
        (crypto-ticker-mode-current-value 0))
    (crypto-ticker-mode-update-status)
    (should (string= " - 0Ð/$" crypto-ticker-mode-modeline-text))))

(ert-deftest crypto-ticker-mode-test/test-returns-correct-difference-symbol ()
  (should (string= " " (crypto-ticker-mode--get-difference-symbol 1 nil)))
  (should (string= crypto-ticker-mode-symbol-same (crypto-ticker-mode--get-difference-symbol 0 0)))
  (should (string= crypto-ticker-mode-symbol-increased (crypto-ticker-mode--get-difference-symbol 1 0)))
  (should (string= crypto-ticker-mode-symbol-decreased (crypto-ticker-mode--get-difference-symbol 0 1))))

(ert-deftest crypto-ticker-mode-test/test-can-format-mode-line ()
  (let ((crypto-ticker-mode-previous-value 0)
        (crypto-ticker-mode-current-value 0))
    (should (string= " - 0Ð/$" (crypto-ticker-mode--format-mode-line)))))

(ert-deftest crypto-ticker-mode-test/test-can-format-mode-line-with-custom-values ()
  (let ((crypto-ticker-mode-previous-value 0)
        (crypto-ticker-mode-current-value 10)
        (crypto-ticker-mode-currency-from-symbol "B")
        (crypto-ticker-mode-currency-to-symbol "£"))
    (should (string= " ↑ 10B/£" (crypto-ticker-mode--format-mode-line)))))

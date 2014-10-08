(require 'f)

(defvar crypto-ticker-mode-support-path
  (f-dirname load-file-name))

(defvar crypto-ticker-mode-features-path
  (f-parent crypto-ticker-mode-support-path))

(defvar crypto-ticker-mode-root-path
  (f-parent crypto-ticker-mode-features-path))

(add-to-list 'load-path crypto-ticker-mode-root-path)

(require 'crypto-ticker-mode)
(require 'espuds)
(require 'ert)

(require 'crypto-ticker-mode-driver-test)

(Setup
 ;; Before anything has run
 (setq crypto-ticker-mode-driver 'crypto-ticker-mode-driver-test))

(Before
 ;; Before each scenario is run
 )

(After
 ;; After each scenario is run
 )

(Teardown
 ;; After when everything has been run
 )

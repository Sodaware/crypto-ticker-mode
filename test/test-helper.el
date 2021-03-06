(require 'cl)
(require 'el-mock)

(add-to-list 'load-path (file-name-directory (directory-file-name (file-name-directory load-file-name))))
(require 'crypto-ticker-mode)

(setq test-directory (file-name-directory (directory-file-name (file-name-directory load-file-name))))

(defun read-fixture (file)
  
  ;; Get the file path
  (let* ((file-path (concat test-directory "/fixtures/" file))
         (file-contents (with-temp-buffer
                          (insert-file-contents file-path)
                          (buffer-string))))
    (json-read-from-string file-contents)))

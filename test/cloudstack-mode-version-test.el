;;; cloudstack-mode-version-test.el --- Tests for version information

;; Copyright (C) 2013 Nicolas Lamirault <nicolas.lamirault@gmail.com>

;; Author   : Nicolas Lamirault <nicolas.lamirault@gmail.com>
;; URL      : https://github.com/nlamirault/cloudstack-mode

;; Commentary:
;; Unit tests for version information

;;; Code:


(require 'test-helper)

(ert-deftest cloudstack-mode-library-version ()
  :expected-result (if (executable-find "cask") :passed :failed)
  ;;  The default directory must end with a slash
  (let* ((cask-version (car (process-lines "cask" "version")))
	 ;;(lib-version (cloudstack-mode-library-version)))
	 )
    ;;(message "CS mode : %s" lib-version)
    (message "CS Cask version: %s" cask-version)
    ;;(should (string= version (cloudstack-mode-library-version)))))
    (should (string= "0.1.0" cask-version))))


;;; version-test.el ends here

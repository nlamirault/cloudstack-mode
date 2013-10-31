;;; cloudstack-mode-commons-test.el --- Tests for commons utilities

;; Copyright (C) 2013 Nicolas Lamirault <nicolas.lamirault@gmail.com>

;; Author   : Nicolas Lamirault <nicolas.lamirault@gmail.com>
;; URL      : https://github.com/nlamirault/cloudstack-mode

;; Commentary:
;; Unit tests for cloudstack-mode commons utilities

;;; Code:


(require 'test-helper)

(ert-deftest cloudstack-mode-cloudstack-uri ()
  ;;  The default directory must end with a slash
  (let* ((cloudstack-host "localhost")
	 (cloudstack-port "9090")
	 (uri (get-cloudstack-uri)))
    (message "CS URI : %s" uri)
    (should (string= "http://localhost:9090/client/api"
		     uri))))

;;; cloudstack-mode-commons-test.el ends here

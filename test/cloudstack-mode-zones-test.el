;;; cloudstack-mode-zones-test.el --- Tests for CS API Zones

;; Copyright (C) 2013 Nicolas Lamirault <nicolas.lamirault@gmail.com>

;; Author   : Nicolas Lamirault <nicolas.lamirault@gmail.com>
;; URL      : https://github.com/nlamirault/cloudstack-mode

;; Commentary:
;; Unit tests for CS API Zones

;;; Code:


(require 'test-helper)

(ert-deftest cloudstack-mode-list-zones ()
  :expected-result (if (executable-find "cask") :passed :failed)
  ;;  The default directory must end with a slash
  (let ((json (cs-list-zones)))
    (message "Json : %s" json)
    (let ((zones (assoc 'zone (cdr (assoc 'listzonesresponse json))))
	  (count (assoc 'count (cdr (assoc 'listzonesresponse json)))))
      (should (= (cdr count)
		 (length (cdr zones)))))))



;;; cloudstack-mode-list-zones-test.el ends here

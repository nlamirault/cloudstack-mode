;;; test-helper.el --- Test helpers for Cloudstack-mode

;; Copyright (C) 2013 Nicolas Lamirault <nicolas.lamirault@gmail.com>

;; Author   : Nicolas Lamirault <nicolas.lamirault@gmail.com>
;; URL      : https://github.com/nlamirault/cloudstack-mode

;; Commentary:
;; Unit test helpers for Cloudstack-mode.

;;; Code:

(require 'f)
(require 's)
(require 'ert)
;;(require 'cloudstack-mode)


(setq debugger-batch-max-lines (+ 50 max-lisp-eval-depth)
      debug-on-error t)


(defconst cloudstack-mode-testsuite-dir (f-parent (f-this-file))
  "The testsuite directory.")

(defconst cloudstack-mode-source-dir
  (f-parent cloudstack-mode-testsuite-dir)
  "The Cloudstack-mode source directory.")

(message "Running tests on Emacs %s" emacs-version)

(message "Load Cloudstack Mode : %s" cloudstack-mode-source-dir)
(load (s-concat cloudstack-mode-source-dir "/cloudstack-mode.elc"))

(load (s-concat cloudstack-mode-testsuite-dir "/resources/cloudstack.el"))

(provide 'test-helper)
;;; test-helper.el ends here

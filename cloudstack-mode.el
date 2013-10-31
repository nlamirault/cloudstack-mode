;;; openstack-mode.el --- an interface to openstack

;; Copyright (C) 2013 Nicolas Lamirault <nicolas.lamirault@gmail.com>

;; Author   : Nicolas Lamirault <nicolas.lamirault@gmail.com>
;; URL      : https://github.com/nlamirault/cloudstack-mode
;; Version  : 0.1
;; Keywords : cloudstack, cloud, api
;; Package-Requires: ((s "1.6.0") (dash "2.0.0") (request "0.2.0") (pkg-info "0.3") (emacs "24.1"))

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;  Cloudstack-mode adds ability to control a Cloudstack infrastructure.
;;  See the README for more details.
;;
;;; Code:


(require 'dash)
(require 'json)
(require 'pkg-info)
;;(require 'request)
(require 's)
(require 'url)

;;;
;;; Customization
;;;

;; (defgroup cloudstack-mode nil
;;   "Manage a Cloudstack infrastructure."
;;   :group 'tools
;;   :group 'convenience)


;; (defcustom cloudstack-host nil
;;   "The Cloudstack API endpoint"
;;   :group 'cloudstack-mode
;;   :type 'string)

;; (defcustom cloudstack-port nil
;;   "The listening port"
;;   :group 'cloudstack-mode
;;   :type 'string)

;; (defcustom cloudstack-apikey nil
;;   "The Cloudstack API key"
;;   :group 'cloudstack-mode
;;   :type 'string)

;; (defcustom cloudstack-secretkey nil
;;   "The Cloudstack API secret key"
;;   :group 'cloudstack-mode
;;   :type 'string)


(defvar cloudstack-host "localhost"
  "The Cloudstack API endpoint")

(defvar cloudstack-port "8080"
   "The listening port")

(defvar cloudstack-apikey nil
   "The Cloudstack API key")

(defvar cloudstack-secretkey nil
   "The Cloudstack API secret key")


;;;
;;; Version informations
;;;

(defun cloudstack-mode-library-version ()
  "Get the version in the Cloudstack-Mode library header."
  (-when-let (version (pkg-info-defining-library-version 'cloudstack-mode))
    (pkg-info-format-version version)))

(defun cloudstack-mode-package-version ()
  "Get the package version of Cloudstack-Mode.
This is the version number of the installed Cloudstack-Mode package."
  (-when-let (version (pkg-info-package-version 'cloudstack-mode))
    (pkg-info-format-version version)))

(defun cloudstack-mode-version (&optional show-version)
  "Get the Cloudstack-mode version as string.

If called interactively or if SHOW-VERSION is non-nil, show the
version in the echo area and the messages buffer.

The returned string includes both, the version from package.el
and the library version, if both a present and different.

If the version number could not be determined, signal an error,
if called interactively, or if SHOW-VERSION is non-nil, otherwise
just return nil."
  (interactive (list (not (or executing-kbd-macro noninteractive))))
  (let* ((lib-version (cloudstack-mode-library-version))
         (pkg-version (cloudstack-mode-package-version))
         (version (cond
                   ((and lib-version pkg-version
                         (not (string= lib-version pkg-version)))
                    (format "%s (package: %s)" lib-version pkg-version))
                   ((or pkg-version lib-version)
                    (format "%s" (or pkg-version lib-version))))))
    (when show-version
      (unless version
        (error "Could not find out Cloudstack-mode version"))
      (message "Cloudstack-mode version: %s" version))
    version))


;; Common API

(defun get-cloudstack-uri ()
  "Retrieve the Cloudstack API endpoint."
  (s-concat "http://" cloudstack-host ":" cloudstack-port "/client/api"))

(defun prepare-cloudstack-request (command)
  "Make the HTTP request."
  (s-concat (get-cloudstack-uri) "?command=" command "&response=json"))

(defun perform-rest-request (command)
  "Perform an HTTP request to the Cloudstack API and return the JSON response."
  (let ((buffer
	 (url-retrieve-synchronously
	  (prepare-cloudstack-request command)))
        (json nil))
    (save-excursion
      (set-buffer buffer)
      (goto-char (point-min))
      (re-search-forward "^$" nil 'move)
      (setq json (buffer-substring-no-properties (point) (point-max)))
      (kill-buffer (current-buffer)))
    json))

(defun extract-json (content)
  "Extract JSON object from content."
  (json-read-from-string content))

(defun cloudstack-command (command)
  "Perform an request to the REST api."
  (extract-json (perform-rest-request command)))

;; API Zones

(defun cs-list-zones ()
  "Lists zones."
  (cloudstack-command "listZones"))


(provide 'cloudstack-mode)

;;; cloudstack-mode.el ends here

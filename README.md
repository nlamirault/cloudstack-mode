Cloudstack Emacs Mode
=====================

``Cloudstack-mode` adds ability to control a
[Cloudstack](http://cloudstack.apache.org/) infrastructure.

## Installation

The recommended way to install ``Cloudstack-mode`` is via [MELPA](http://melpa.milkbox.net/)
or [Marmalade](http://marmalade-repo.org/).


## Usage

### Basic setup

Setup your Cloudstack configuration :

    (setq cloudstack-host "")
	(setq cloudstack-port "")
    (setq cloudstack-apikey "")
    (setq cloudstack-secretkey "")

### Available commands

* List zones

        M-x cloudstack-zones


## Development

### Cask

``Cloudstack-mode`` use [Cask](https://github.com/cask/cask) for dependencies
management. Install it and retrieve dependencies :

    $ curl -fsSkL https://raw.github.com/cask/cask/master/go | python
	$ export PATH="$HOME/.cask/bin:$PATH"
	$ cask

### Tests

Launch unit tests :

    $ /usr/bin/env emacs --script test/run-tests

## Changelog

A changelog is available [here](ChangeLog.md).

## Contact

Nicolas Lamirault <nicolas.lamirault@gmail.com>

EMACS = emacs
EMACSFLAGS =
CASK = cask
VAGRANT = vagrant

OBJECTS = cloudstack-mode.elc

elpa:
	$(CASK) install
	$(CASK) update
	touch $@

.PHONY: build
build : elpa $(OBJECTS)

.PHONY: test
test : build
	${CASK} exec ert-runner --no-win

.PHONY: virtual-test
virtual-test :
	$(VAGRANT) up
	$(VAGRANT) ssh -c "make -C /vagrant EMACS=$(EMACS) clean test"

.PHONY: clean
clean :
	rm -f $(OBJECTS)
	rm -f elpa
	rm -rf .cask # Clean packages installed for development

%.elc : %.el
	$(CASK) exec $(EMACS) --no-site-file --no-site-lisp --batch \
		$(EMACSFLAGS) \
		-f batch-byte-compile $<

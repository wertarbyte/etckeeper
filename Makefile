# You should configure etckeeper.conf for your distribution before
# installing etckeeper.
CONFFILE=etckeeper.conf
include $(CONFFILE)

install:
	mkdir -p $(PREFIX)/etc/etckeeper/
	cp -a *.d $(PREFIX)/etc/etckeeper/
	cp $(CONFFILE) $(PREFIX)/etc/etckeeper/etckeeper.conf
	install -D etckeeper $(PREFIX)/usr/bin/etckeeper
	install -m 0644 -D etckeeper.1 $(PREFIX)/usr/share/man/man1/etckeeper.1
	install -m 0644 -D bash_completion $(PREFIX)/etc/bash_completion.d/etckeeper
ifeq ($(HIGHLEVEL_PACKAGE_MANAGER),apt))
	install -m 0644 -D apt.conf $(PREFIX)/etc/apt/apt.conf.d/05etckeeper
endif
ifeq ($(LOWLEVEL_PACKAGE_MANAGER),pacman-g2))
	install -m 0644 -D pacman-g2.hook $(PREFIX)/etc/pacman-g2/hooks/etckeeper
endif

install:
	mkdir -p $(PREFIX)/etc/etckeeper/
	cp -a *.d $(PREFIX)/etc/etckeeper/
	cp etckeeper.conf $(PREFIX)/etc/etckeeper/
	install -D etckeeper $(PREFIX)/usr/bin/etckeeper
ifeq ($(PACKAGE_MANAGER),)
	install -m 0644 -D apt.conf $(PREFIX)/etc/apt/apt.conf.d/05etckeeper
endif
ifeq ($(PACKAGE_MANAGER),pacman-g2)
	install -m 0644 -D pacman-g2.hook $(PREFIX)/etc/pacman-g2/hooks/etckeeper
endif
	install -m 0644 -D etckeeper.1 $(PREFIX)/usr/share/man/man1/etckeeper.1
	install -m 0644 -D bash_completion $(PREFIX)/etc/bash_completion.d/etckeeper
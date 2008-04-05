# You should configure etckeeper.conf for your distribution before
# installing etckeeper.
CONFFILE=etckeeper.conf
include $(CONFFILE)

DESTDIR?=
prefix=/usr
bindir=${prefix}/bin
etcdir=/etc
mandir=${prefix}/share/man
vardir=/var

INSTALL=install 
INSTALL_EXE=${INSTALL} -D
INSTALL_DATA=${INSTALL} -m 0644 -D

install:
	mkdir -p $(DESTDIR)$(etcdir)/etckeeper/ $(DESTDIR)$(vardir)/cache/etckeeper/
	cp -a *.d $(DESTDIR)$(etcdir)/etckeeper/
	$(INSTALL_DATA) $(CONFFILE) $(DESTDIR)$(etcdir)/etckeeper/etckeeper.conf
	$(INSTALL_EXE) etckeeper $(DESTDIR)$(bindir)/etckeeper
	$(INSTALL_DATA) etckeeper.1 $(DESTDIR)$(mandir)/man1/etckeeper.1
	$(INSTALL_DATA) bash_completion $(DESTDIR)$(etcdir)/bash_completion.d/etckeeper
ifeq ($(HIGHLEVEL_PACKAGE_MANAGER),apt)
	$(INSTALL_DATA) apt.conf $(DESTDIR)$(etcdir)/apt/apt.conf.d/05etckeeper
endif
ifeq ($(LOWLEVEL_PACKAGE_MANAGER),pacman-g2)
	$(INSTALL_DATA) pacman-g2.hook $(DESTDIR)$(etcdir)/pacman-g2/hooks/etckeeper
endif
	-./etckeeper-bzr/__init__.py install --root=$(DESTDIR)

DESTDIR        ?=
prefix         	= /usr
bindir       	= ${prefix}/bin
etcdir       	= /etc
mandir          = ${prefix}/man1

INSTALL         = install 
INSTALL_EXE     = ${INSTALL}
INSTALL_DATA    = ${INSTALL} -m 0644 -D

install:
	mkdir -p $(DESTDIR)$(etcdir)/etckeeper/
	$(INSTALL_DATA) etckeeper.conf $(DESTDIR)$(etcdir)/etckeeper/etckeeper.conf
	cp -a *.d $(DESTDIR)$(etcdir)/etckeeper/
	chown root.root -R $(DESTDIR)$(etcdir)/etckeeper/
	$(INSTALL_EXE) etckeeper $(DESTDIR)$(bindir)/etckeeper
	$(INSTALL_DATA) apt.conf $(DESTDIR)$(etcdir)/apt/apt.conf.d/05etckeeper
	$(INSTALL_DATA) etckeeper.1 $(DESTDIR)$(mandir)/man1/etckeeper.1
	$(INSTALL_DATA) bash_completion $(DESTDIR)$(etcdir)/bash_completion.d/etckeeper

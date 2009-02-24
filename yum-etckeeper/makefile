DESTDIR?=
prefix=/usr
etcdir=/etc
CONFFILE=etckeeper.conf

INSTALL=install 
INSTALL_EXE=${INSTALL} -D
INSTALL_DATA=${INSTALL} -m 0644 -D

PACKAGE=yum-etckeeper
DISTFILE=$(PACKAGE).tar.gz

dist: $(DISTFILE)

$(DISTFILE):
	tar -C .. --exclude .git --exclude $(DISTFILE) \
	--exclude \*.diff --exclude .gitignore \
	--exclude .svn \
	--exclude \*.swp \
	-cvzf $(DISTFILE) $(PACKAGE)

install:
	mkdir -p $(DESTDIR)$(etcdir)/etckeeper/list-installed.d $(DESTDIR)$(prefix)/lib/yum-plugins $(DESTDIR)$(etcdir)/yum/pluginconf.d
	$(INSTALL_DATA) $(CONFFILE) $(DESTDIR)$(etcdir)/yum/pluginconf.d/etckeeper.conf
	$(INSTALL_DATA) etckeeper.py $(DESTDIR)$(prefix)/lib/yum-plugins/etckeeper.py
	$(INSTALL_EXE) list-installed.d/60list-installed $(DESTDIR)$(etcdir)/etckeeper/list-installed.d/60list-installed

rpms: dist
	rpmbuild -ta $(DISTFILE)

clean:
	-rm -f $(DISTFILE)

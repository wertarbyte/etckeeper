# You should configure etckeeper.conf for your distribution before
# installing etckeeper.
CONFFILE=etckeeper.conf
include $(CONFFILE)

DESTDIR?=
prefix=/usr
sbindir=${prefix}/sbin
etcdir=/etc
mandir=${prefix}/share/man
vardir=/var

INSTALL=install 
INSTALL_EXE=${INSTALL} -D
INSTALL_DATA=${INSTALL} -m 0644 -D

build: etckeeper.spec
	-./etckeeper-bzr/__init__.py build || echo "** bzr support not built"
	
install:
	mkdir -p $(DESTDIR)$(etcdir)/etckeeper/ $(DESTDIR)$(vardir)/cache/etckeeper/
	cp -dR *.d $(DESTDIR)$(etcdir)/etckeeper/
	$(INSTALL_DATA) $(CONFFILE) $(DESTDIR)$(etcdir)/etckeeper/etckeeper.conf
	$(INSTALL_EXE) etckeeper $(DESTDIR)$(sbindir)/etckeeper
	$(INSTALL_DATA) etckeeper.8 $(DESTDIR)$(mandir)/man8/etckeeper.8
	$(INSTALL_DATA) bash_completion $(DESTDIR)$(etcdir)/bash_completion.d/etckeeper
ifeq ($(HIGHLEVEL_PACKAGE_MANAGER),apt)
	$(INSTALL_DATA) apt.conf $(DESTDIR)$(etcdir)/apt/apt.conf.d/05etckeeper
	mkdir -p $(DESTDIR)$(etcdir)/cruft/filters-unex
	$(INSTALL_DATA) cruft_filter $(DESTDIR)$(etcdir)/cruft/filters-unex/etckeeper
endif
ifeq ($(LOWLEVEL_PACKAGE_MANAGER),pacman-g2)
	$(INSTALL_DATA) pacman-g2.hook $(DESTDIR)$(etcdir)/pacman-g2/hooks/etckeeper
endif
ifeq ($(HIGHLEVEL_PACKAGE_MANAGER),yum)
	$(INSTALL_DATA) yum-etckeeper.py $(DESTDIR)$(prefix)/lib/yum-plugins/etckeeper.py
	$(INSTALL_DATA) yum-etckeeper.conf $(DESTDIR)$(etcdir)/yum/pluginconf.d/etckeeper.conf
endif
	-./etckeeper-bzr/__init__.py install --root=$(DESTDIR) || echo "** bzr support not installed"
	echo "** installation successful"

clean: etckeeper.spec
	rm -rf build

etckeeper.spec:
	sed -i~ "s/Version:.*/Version: $$(perl -e '$$_=<>;print m/\((.*?)\)/'<debian/changelog)/" etckeeper.spec
	rm -f etckeeper.spec~

.PHONY: etckeeper.spec

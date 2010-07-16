Name: etckeeper
Version: 0.48
Release: 4%{?dist}
Summary: store /etc in git, mercurial, bzr or darcs

Group: System Tools
License: GPLv2
URL: http://kitenet.net/~joey/code/etckeeper/
Source0: http://ftp.debian.org/debian/pool/main/e/etckeeper/%{name}_%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

Requires: git >= 1.6.1-1
Obsoletes: etckeeper = snapshot, yum-etckeeper

%description
The etckeeper program is a tool to let /etc be stored in a git,
mercurial, bzr or darcs repository. It hooks into yum to automatically
commit changes made to /etc during package upgrades. It tracks file
metadata that version control systems do not normally support, but that
is important for /etc, such as the permissions of /etc/shadow. It's
quite modular and configurable, while also being simple to use if you
understand the basics of working with version control.

%prep
%setup -q -n %{name}
%{__perl} -pi -e '
	s|HIGHLEVEL_PACKAGE_MANAGER=apt|HIGHLEVEL_PACKAGE_MANAGER=yum|;
	s|LOWLEVEL_PACKAGE_MANAGER=dpkg|LOWLEVEL_PACKAGE_MANAGER=rpm|;
	' %{_builddir}/%{name}/etckeeper.conf


%build
make %{?_smp_mflags}


%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT
install -D debian/cron.daily $RPM_BUILD_ROOT/etc/cron.daily/etckeeper


%clean
rm -rf $RPM_BUILD_ROOT

%post
%{_sbindir}/etckeeper init -d /etc/
mkdir -p %{_var}/cache/etckeeper

%files
%defattr(-,root,root,-)
%doc GPL INSTALL TODO README
%{_sbindir}/*
%{_mandir}/*
# this isn't very clever and its a manual process update.
# but it works
%config(noreplace) /etc/yum/pluginconf.d/etckeeper.conf
%config(noreplace) /etc/etckeeper/etckeeper.conf
/etc/etckeeper/*.d/*
/etc/cron.daily/etckeeper
/etc/bash_completion.d/etckeeper
%{_prefix}/lib/*

%changelog
* Fri Feb 27 2009 Jimmy Tang <jtang@tchpc.tcd.ie> - 0.33-4
- fix up initial install to make directory in /var/cache/etckeeper
- install the etckeeper daily cron job
- define some config files that shouldn't be replaced, should the hooks
in commit.d, init.d etc... saved and not blown away? if so they can
defined as config files. etckeeper should record the changes anyway.

* Wed Feb 25 2009 Jimmy Tang <jtang@tchpc.tcd.ie> - 0.32-1
- yum etckeeper plugin is now apart of this package

* Tue Feb 24 2009 Jimmy Tang <jtang@tchpc.tcd.ie> - 0.31-1
- initial package

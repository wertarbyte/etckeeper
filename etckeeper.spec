Name:           etckeeper
Version:        0.31
Release:        1%{?dist}
Summary:        store /etc in git, mercurial, bzr or darcs

Group:          System Tools
License:        GPLv2
URL:            http://kitenet.net/~joey/code/etckeeper/
Source0:        http://ftp.de.debian.org/debian/pool/main/e/etckeeper/%{name}_%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

Requires:       git >= 1.6.1-1
Obsoletes:	etckeeper = snapshot

%description
The etckeeper program is a tool to let /etc be stored in a git,
mercurial, bzr or darcs repository. It hooks into APT to automatically
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


%clean
rm -rf $RPM_BUILD_ROOT

%post
%{_sbindir}/etckeeper init -d /etc/

%files
%defattr(-,root,root,-)
%doc GPL INSTALL TODO bash_completion README
%{_sbindir}/*
%{_mandir}/*
/etc/*


%changelog
* Tue Feb 24 2009 Jimmy Tang <jtang@tchpc.tcd.ie> - 0.31-1
- initial package

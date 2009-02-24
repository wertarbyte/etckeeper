Name:           yum-etckeeper
Version:        snapshot
Release:        9%{?dist}
Summary:        etckeeper pre and post transaction hook for yum

Group:          System Environment/Base
License:        TCD
URL:            http://www.tchpc.tcd.ie
Source0:        yum-etckeeper.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildRequires:  etckeeper >= 0.31, yum, git >= 1.6.0.3-1
Requires:       etckeeper >= 0.31, yum, git >= 1.6.0.3-1

%description
etckeeper pre and post transaction hook for yum

%prep
%setup -q -n yum-etckeeper


%build
exit 0

%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT


%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc AUTHORS  LICENSE  README
/etc/etckeeper/list-installed.d/60list-installed
/etc/yum/pluginconf.d/etckeeper.conf
/usr/lib/yum-plugins/etckeeper.py*


%changelog
* Tue Feb 24 2009 Jimmy Tang <jtang@tchpc.tcd.ie> - snapshot-9
- ignore previous change, since I've packaged up etckeeper properly now
* Tue Feb 24 2009 Jimmy Tang <jtang@tchpc.tcd.ie> - snapshot-7
- upstream etckeeper has a list installed script for rpm so 
removing my own one
* Mon Feb 16 2009 Jimmy Tang <jtang@tchpc.tcd.ie> - snapshot-4
- made it work in sl4
* Mon Feb 16 2009 Jimmy Tang <jtang@tchpc.tcd.ie> - snapshot-1
- initial package

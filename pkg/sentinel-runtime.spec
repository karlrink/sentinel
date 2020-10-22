
%global _python_bytecompile_extra 0

# Turn off the brp-python-bytecompile script
%global __os_install_post %(echo '%{__os_install_post}' | sed -e 's!/usr/lib[^[:space:]]*/brp-python-bytecompile[[:space:]].*$!!g')

%define bindir  /usr/bin
%define sbindir /usr/sbin

Summary: Sentinel Python 3.8.6 runtime tools
Name: sentinel-runtime
Version: v1.6.7
Release: 0%{?dist}
License: GPL
#URL: https://gitlab.com/krink/sentinel/-/archive/master/sentinel-master.tar.gz
Group: Applications/Internet
Source0: sentinel-runtime-%{version}.tar.gz

BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch: x86_64

%if 0%{?rhel} == 7
AutoReqProv: no
#Requires: python38
%endif

%if 0%{?rhel} == 6
AutoReqProv: no
#Requires: python27
%endif

Requires(pre): /usr/sbin/useradd, /usr/bin/getent
Requires(postun): /usr/sbin/userdel

Provides: sentinel-runtime

%description
Sentinel service runtime tools

%prep
tar xzvf %{SOURCE0}

%install
rm -rf $RPM_BUILD_ROOT
#exit 0

%if 0%{?rhel} == 7
#mkdir -p $RPM_BUILD_ROOT/lib/systemd/system
#cp sentinel-%{version}/pkg/linux.sentinel.service $RPM_BUILD_ROOT/lib/systemd/system/sentinel.service
%endif

%if 0%{?rhel} == 6
#mkdir -p $RPM_BUILD_ROOT/etc/init.d
#cp sentinel-%{version}/pkg/sentinel.init $RPM_BUILD_ROOT/etc/init.d/sentinel
#chmod 755 $RPM_BUILD_ROOT/etc/init.d/sentinel
%endif

mkdir -p $RPM_BUILD_ROOT/usr/libexec/sentinel

cp -r sentinel-runtime-%{version}/runtime $RPM_BUILD_ROOT/usr/libexec/sentinel/
#cp -a /usr/libexec/sentinel/runtime $RPM_BUILD_ROOT/usr/libexec/sentinel/

#cp sentinel-%{version}/python/sentinel.py $RPM_BUILD_ROOT/usr/libexec/sentinel/sentinel.py
#chmod 755 $RPM_BUILD_ROOT/usr/libexec/sentinel/sentinel.py

%clean
rm -rf $RPM_BUILD_ROOT

%pre
# Add user/group here if needed...
#echo "Add user/group here if needed..." >/dev/null 2>&1
#/usr/bin/getent group sentinel > /dev/null || /usr/sbin/groupadd -r sentinel
#/usr/bin/getent passwd sentinel > /dev/null || /usr/sbin/useradd -r -d /usr/libexec/sentinel -s /sbin/nologin -g sentinel sentinel

%post
# Add serivces for startup
%if 0%{?rhel} == 6
  echo "rh6"
  if [ $1 = 1 ]; then #1 install
    echo "start sentinel"
  else
    echo "restart sentinel"
  fi
%endif

%if 0%{?rhel} == 7
  echo "systemctl daemon-reload"
  if [ $1 = 1 ]; then #1 install
    echo "systemctl enable sentinel"
    echo "systemctl start sentinel"
  else
    echo "systemctl restart sentinel"
  fi
%endif

#end post

%postun
echo "postrun.done"

%files
%defattr(-,root,root)

%if 0%{?rhel} == 7
#/lib/systemd/system/sentinel.service
%endif

%if 0%{?rhel} == 6
#/etc/init.d/sentinel
%endif

#----

#%dir /usr/libexec/sentinel/runtime
/usr/libexec/sentinel/runtime

#----

%if 0%{?rhel} == 7
#%exclude /usr/lib/python2.7/site-packages/scrawl/*.pyc
#%exclude /usr/lib/python2.7/site-packages/scrawl/*.pyo
%endif

%if 0%{?rhel} == 6
#%exclude /usr/lib/python2.6/site-packages/scrawl/*.pyc
#%exclude /usr/lib/python2.6/site-packages/scrawl/*.pyo
%endif

#%exclude /usr/libexec/sentinel/runtime/*.pyc
#%exclude /usr/libexec/sentinel/runtime/*/*.pyc
#%exclude /usr/libexec/sentinel/runtime/*/*/*.pyc
%exclude /usr/libexec/sentinel/runtime/*/*/*/*.pyc
%exclude /usr/libexec/sentinel/runtime/*/*/*/*/*.pyc
%exclude /usr/libexec/sentinel/runtime/*/*/*/*/*/*.pyc
%exclude /usr/libexec/sentinel/runtime/*/*/*/*/*/*/*.pyc
%exclude /usr/libexec/sentinel/runtime/*/*/*/*/*/*/*/*.pyc
%exclude /usr/libexec/sentinel/runtime/*/*/*/*/*/*/*/*/*.pyc
%exclude /usr/libexec/sentinel/runtime/*/*/*/*/*/*/*/*/*/*.pyc
#%exclude /usr/libexec/sentinel/runtime/*/*/*/*/*/*/*/*/*/*/*.pyc

%exclude /usr/libexec/sentinel/runtime/lib/python3.8/test/*
%exclude /usr/libexec/sentinel/runtime/include/*

#%exclude /usr/libexec/sentinel/Python3.8.6/*.pyo
#%exclude /usr/libexec/sentinel/Python3.8.6/modules/ps/*.pyc
#%exclude /usr/libexec/sentinel/Python3.8.6/modules/ps/*.pyo

%changelog
* Tue Oct 20 2020 Karl Rink <karl@rink.us> v1.6.7-0
- .gitlab-ci.yml please

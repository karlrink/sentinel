#!/bin/bash

basedir=`dirname $0`

mkdir ~/dpkgbuild >/dev/null 2>&1

if [ ! -f ~/dpkgbuild/sentinel-master.tar.gz ]; then
  curl -k https://gitlab.com/krink/sentinel/-/archive/master/sentinel-master.tar.gz >~/dpkgbuild/sentinel-master.tar.gz
fi

tar xvf ~/dpkgbuild/sentinel-master.tar.gz -C ~/dpkgbuild/

ver=`awk '/^Version: / {print $2}' ~/dpkgbuild/sentinel-master/pkg/control`

mkdir -p ~/dpkgbuild/sentinel/usr/libexec/sentinel

cp ~/dpkgbuild/sentinel-master/src/sentinel_server/sentinel.py ~/dpkgbuild/sentinel/usr/libexec/sentinel/sentinel.py
cp ~/dpkgbuild/sentinel-master/src/sentinel_server/tools.py ~/dpkgbuild/sentinel/usr/libexec/sentinel/tools.py
cp ~/dpkgbuild/sentinel-master/src/sentinel_server/store.py ~/dpkgbuild/sentinel/usr/libexec/sentinel/store.py
cp ~/dpkgbuild/sentinel-master/src/sentinel_server/manuf.py ~/dpkgbuild/sentinel/usr/libexec/sentinel/manuf.py

mkdir ~/dpkgbuild/sentinel/usr/libexec/sentinel/db
cp ~/dpkgbuild/sentinel-master/src/sentinel_server/db/manuf ~/dpkgbuild/sentinel/usr/libexec/sentinel/db/

mkdir -p ~/dpkgbuild/sentinel/usr/libexec/sentinel/modules/ps
cp ~/dpkgbuild/sentinel-master/src/sentinel_server/modules/ps/ps.py ~/dpkgbuild/sentinel/usr/libexec/sentinel/modules/ps/ps.py

mkdir -p ~/dpkgbuild/sentinel/usr/libexec/sentinel/modules/hv
cp ~/dpkgbuild/sentinel-master/src/sentinel_server/modules/hv/kvm.py ~/dpkgbuild/sentinel/usr/libexec/sentinel/modules/hv/kvm.py
cp ~/dpkgbuild/sentinel-master/src/sentinel_server/modules/hv/__init__.py ~/dpkgbuild/sentinel/usr/libexec/sentinel/modules/hv/__init__.py

mkdir -p ~/dpkgbuild/sentinel/lib/systemd/system
cp ~/dpkgbuild/sentinel-master/pkg/linux.sentinel.service ~/dpkgbuild/sentinel/lib/systemd/system/sentinel.service

mkdir -p ~/dpkgbuild/sentinel/usr/sbin
cp ~/dpkgbuild/sentinel-master/pkg/sentinel.sh ~/dpkgbuild/sentinel/usr/sbin/sentinel

mkdir  ~/dpkgbuild/sentinel/DEBIAN
cp ~/dpkgbuild/sentinel-master/pkg/control ~/dpkgbuild/sentinel/DEBIAN/

mkdir -p $basedir/package >/dev/null 2>&1

cd ~/dpkgbuild
dpkg-deb --build sentinel
mv sentinel.deb sentinel-${ver}_amd64.deb
cd -

#dpkg-deb --build ~/dpkgbuild/sentinel
#cp sentinel.deb $basedir/sentinel-${ver}_amd64.deb
#cp sentinel.deb $basedir/package/sentinel-${ver}_amd64.deb 



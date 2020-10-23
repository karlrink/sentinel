#!/bin/bash

basedir=`dirname $0`
ver=`awk '/^Version: / {print $2}' $basedir/control-runtime`

mkdir ~/dpkgbuild/sentinel-runtime >/dev/null 2>&1

#https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz
if [ ! -f ~/dpkgbuild/Python-3.8.6.tgz ]; then
  curl -k https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz >~/dpkgbuild/Python-3.8.6.tgz
  tar xvf ~/dpkgbuild/Python-3.8.6.tgz -C ~/dpkgbuild/
fi

#https://www.sqlite.org/2020/sqlite-autoconf-3330000.tar.gz
if [ ! -f ~/dpkgbuild/sqlite-autoconf-3330000.tar.gz ]; then
  curl -k https://www.sqlite.org/2020/sqlite-autoconf-3330000.tar.gz >~/dpkgbuild/sqlite-autoconf-3330000.tar.gz
  tar xvf ~/dpkgbuild/sqlite-autoconf-3330000.tar.gz -C ~/dpkgbuild/
fi

cd ~/dpkgbuild/sqlite-autoconf-3330000
./configure --prefix=/usr/libexec/sentinel/runtime
make 
make install

cd ~/dpkgbuild/Python-3.8.6
LD_RUN_PATH=/usr/libexec/sentinel/runtime/lib ./configure --enable-optimizations --prefix=/usr/libexec/sentinel/runtime
LD_RUN_PATH=/usr/libexec/sentinel/runtime/lib make
LD_RUN_PATH=/usr/libexec/sentinel/runtime/lib make altinstall

cd /usr/libexec/sentinel/runtime/bin
ln -s python3.8 python3


mkdir -p ~/dpkgbuild/sentinel-runtime/usr/libexec/sentinel
rsync -a /usr/libexec/sentinel/runtime ~/dpkgbuild/sentinel-runtime/usr/libexec/sentinel/



#mkdir -p ~/dpkgbuild/sentinel/usr/libexec/sentinel
#cp ~/dpkgbuild/sentinel-master/python/sentinel.py ~/dpkgbuild/sentinel/usr/libexec/sentinel/sentinel.py

mkdir  ~/dpkgbuild/sentinel-runtime/DEBIAN
cp $basedir/control-runtime ~/dpkgbuild/sentinel-runtime/DEBIAN/control

cd ~/dpkgbuild
dpkg-deb --build sentinel-runtime
cp sentinel-runtime.deb sentinel-runtime-${ver}_amd64.deb

mkdir -p $basedir/package >/dev/null 2>&1
cp ~/dpkgbuild/sentinel-runtime.deb $basedir/package/sentinel-runtime-${ver}_amd64.deb

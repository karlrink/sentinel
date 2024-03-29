#!/bin/bash

basedir=`dirname $0`

mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS} >/dev/null 2>&1

if [ ! -f ~/rpmbuild/SOURCES/sentinel-$ver.tar.gz ]; then
  curl -k https://gitlab.com/krink/sentinel/-/archive/master/sentinel-master.tar.gz >~/rpmbuild/SOURCES/sentinel-master.tar.gz
fi

tar xvf ~/rpmbuild/SOURCES/sentinel-master.tar.gz -C ~/rpmbuild/SOURCES/

ver=`awk '/^Version: / {print $2}' ~/rpmbuild/SOURCES/sentinel-master/pkg/sentinel-runtime.spec`
cp ~/rpmbuild/SOURCES/sentinel-master/pkg/sentinel-runtime.spec ~/rpmbuild/SPECS/sentinel-runtime.spec

#---

#https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz
if [ ! -f ~/rpmbuild/SOURCES/Python-3.8.6.tgz ]; then
  curl -k https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz >~/rpmbuild/SOURCES/Python-3.8.6.tgz
  tar xvf ~/rpmbuild/SOURCES/Python-3.8.6.tgz -C ~/rpmbuild/SOURCES/
fi

#https://www.sqlite.org/2020/sqlite-autoconf-3330000.tar.gz
if [ ! -f ~/rpmbuild/SOURCES/sqlite-autoconf-3330000.tar.gz ]; then
  curl -k https://www.sqlite.org/2020/sqlite-autoconf-3330000.tar.gz >~/rpmbuild/SOURCES/sqlite-autoconf-3330000.tar.gz
  tar xvf ~/rpmbuild/SOURCES/sqlite-autoconf-3330000.tar.gz -C ~/rpmbuild/SOURCES/
fi

cd ~/rpmbuild/SOURCES/sqlite-autoconf-3330000
./configure --prefix=/usr/libexec/sentinel/runtime
make 
make install

cd ~/rpmbuild/SOURCES/Python-3.8.6

#export LD_LIBRARY_PATH=/usr/libexec/sentinel/runtime/lib
#export PATH=/usr/libexec/sentinel/runtime/bin:/usr/bin:/usr/sbin:/bin:/sbin
#export PYTHONPATH=/usr/libexec/sentinel/runtime/lib/python3.8/site-packages
#export PYTHONPATH=/usr/libexec/sentinel/runtime/lib/python3.8

#centos7
#Error: Could not import runpy module
#1. Upgrade gcc to a higher version, gcc 8.1.0 has fixed this problem
#2. Remove --enable-optimizations from the ./configure parameter

if grep -q -i "release 7" /etc/redhat-release ; then
  LD_RUN_PATH=/usr/libexec/sentinel/runtime/lib ./configure --prefix=/usr/libexec/sentinel/runtime
else
  LD_RUN_PATH=/usr/libexec/sentinel/runtime/lib ./configure --enable-optimizations --prefix=/usr/libexec/sentinel/runtime
fi

#LD_RUN_PATH=/usr/libexec/sentinel/runtime/lib ./configure --enable-optimizations --prefix=/usr/libexec/sentinel/runtime
LD_RUN_PATH=/usr/libexec/sentinel/runtime/lib make
LD_RUN_PATH=/usr/libexec/sentinel/runtime/lib make altinstall

#libvirt
#https://libvirt.org/sources/python/libvirt-python-7.2.0.tar.gz
if [ ! -f ~/rpmbuild/SOURCES/libvirt-python-7.2.0.tar.gz ]; then
  curl -k https://libvirt.org/sources/python/libvirt-python-7.2.0.tar.gz >~/rpmbuild/SOURCES/libvirt-python-7.2.0.tar.gz
  tar xvf ~/rpmbuild/SOURCES/libvirt-python-7.2.0.tar.gz -C ~/rpmbuild/SOURCES/
fi
cd ~/rpmbuild/SOURCES/libvirt-python-7.2.0
#./configure --prefix=/usr/libexec/sentinel/runtime
/usr/libexec/sentinel/runtime/bin/python3.8 setup.py build
/usr/libexec/sentinel/runtime/bin/python3.8 setup.py install --prefix=/usr/libexec/sentinel/runtime

echo "Compiler Done"

# install python requests
/usr/libexec/sentinel/runtime/bin/python3.8 -m pip install requests

# /usr/libexec/sentinel/runtime/lib/python3.8/site-packages/pip/_vendor/requests/utils.py
mv /usr/libexec/sentinel/runtime/lib/python3.8/site-packages/pip/_vendor/requests /usr/libexec/sentinel/runtime/lib/python3.8/site-packages/pip/

cd /usr/libexec/sentinel/runtime/bin
ln -s python3.8 python3
cd /usr/libexec/sentinel/
if [ -d sentinel-runtime-$ver ]; then
  echo "remove existing sentinel-runtime-$ver"
  rm -rf sentinel-runtime-$ver
fi
mkdir sentinel-runtime-$ver
mv runtime sentinel-runtime-$ver/
tar cvfz sentinel-runtime-$ver.tar.gz sentinel-runtime-$ver
cp sentinel-runtime-$ver.tar.gz ~/rpmbuild/SOURCES/

cd $basedir/

#rpmbuild -tb ~/rpmbuild/SOURCES/sentinel-runtime-$ver.tar.gz
rpmbuild -ba ~/rpmbuild/SPECS/sentinel-runtime.spec

mkdir -p $basedir/package >/dev/null 2>&1
#cp ~/rpmbuild/SRPMS/*.rpm $basedir/package/
cp ~/rpmbuild/RPMS/x86_64/*.rpm $basedir/package/ >/dev/null 2>&1
#cp ~/rpmbuild/RPMS/noarch/*.rpm $basedir/package/





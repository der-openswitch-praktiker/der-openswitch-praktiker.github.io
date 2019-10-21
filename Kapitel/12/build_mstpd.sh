#!/bin/bash

# purpose: compile and install MSTPD 

# autogen.sh requires "autoreconf", which is provided by autoconf package
which autoreconf >/dev/null
if [ $? == 1 ] ; then
  apt install -y autoconf
fi

# get the current release from github
cd /usr/src/
rm -rf mstpd-0.0.8*
wget -O mstpd-0.0.8.tar.gz https://github.com/mstpd/mstpd/archive/0.0.8.tar.gz

# extract and compile
tar xfz mstpd-0.0.8.tar.gz
cd mstpd-0.0.8/
./autogen.sh
./configure --prefix=/usr --sysconfdir=/etc
make
make install

# clean-up
rm -rf /usr/src/mstpd-0.0.8*

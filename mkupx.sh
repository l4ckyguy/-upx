#!/bin/bash

function make_zlib() {
        home="$(pwd)" ; rm -r /tmp/zlib* &> /dev/null
        wget -O /tmp/zlib.tar.gz http://zlib.net/zlib-1.2.12.tar.gz ; cd /tmp ; tar xf zlib.tar.gz ; cd zlib-1.2.12
        ./configure --static ; make -j7 ; make install
        cd $home
}

function make_ucl() {
        home="$(pwd)" ; rm -r /tmp/ucl* &> /dev/null
        wget https://www.oberhumer.com/opensource/ucl/download/ucl-1.03.tar.gz -O /tmp/ucl.tar.gz ; cd /tmp ; tar xf ucl.tar.gz
        cd ucl-1.03 ;  ./configure CPPFLAGS="$CPPFLAGS -std=c90 -fPIC" ; make -j7 ; make install ; cd $home
}

mkdir -p $HOME/bin

	git clone --recurse-submodules https://github.com/upx/upx $HOME/bin/upx
	wget -O /tmp/stub.tar.gz https://github.com/upx/upx-stubtools/releases/download/v20210104/bin-upx-20210104.tar.xz
	tar xf /tmp/stub.tar.gz -C /tmp/ ; mv /tmp/bin-upx-20210104 $HOME/bin/bin-upx
	wget -O /tmp/lib4.deb http://ftp.us.debian.org/debian/pool/main/m/mpfr4/libmpfr4_3.1.5-1_amd64.deb
	dpkg -i /tmp/lib4.deb ; apt-get -y -f install

	cd $HOME/bin/upx ; make_zlib ; make_ucl ; make -j7

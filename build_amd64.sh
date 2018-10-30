#!/bin/bash
srcurl="https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.1-linux-x86_64.tar.gz"
srcdir="julia-1.0.1"
version="1.0.1"

tmpdir=$(mktemp -d)

wget $srcurl -O $tmpdir/julia.tar.gz
tar zxvf $tmpdir/julia.tar.gz
rm -rf $tmpdir

mkdir ./pkgroot

mkdir -p ./pkgroot/opt
mv -f $srcdir ./pkgroot/opt/julia-standalone

mkdir -p ./pkgroot/usr/bin
ln -sf /opt/julia-standalone/bin/julia ./pkgroot/usr/bin/julia

cp -r DEBIAN ./pkgroot/
dpkg-deb --build pkgroot julia-standalone-${version}_amd64.deb

rm -rf ./pkgroot

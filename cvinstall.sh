#!/bin/bash
# This shell is used to build opencv library
# Note: make sure this shell placed at the same directory with opencv package and ippicv package

# ippicv package name
ipp_pkg=ippicv_linux_20151201.tgz

# the root directory name of opencv source code 
root_dir=opencv-3.1.0

cd $root_dir

ipp_file=../$ipp_pkg &&
ipp_hash=$(md5sum $ipp_file | cut -d" " -f1) &&
ipp_dir=3rdparty/ippicv/downloads/linux-$ipp_hash &&
mkdir -p $ipp_dir &&
cp $ipp_file $ipp_dir

# create new folder and enter
mkdir build &&
cd build

# method 1: generate Makefile only static library file
#cmake -DBUILD_SHARED_LIBS=OFF ../

# method 2: generate Makefile with dynamic library file  for C/C++ developer
# Parameter Explanations:
#	-DWITH_XINE=ON : this option instructs the make procedure to use xine-lib-1.2.6
#	-DWITH_IPP=ON: this option instructs the make procedure to sue the downloaded IPP package

cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
	-DCMAKE_BUILD_TYPE=RELEASE \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_TESTS=OFF \
	../

# compile
make -j8

# install
#make install

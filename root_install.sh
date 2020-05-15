#!/bin/sh
#
# Auto ROOT install
# Based on cmake_geant4 by github wdconinc 
#
# 
##################################
##################################
#		How to Run
##################################
#
# From terminal
# chmod +x root_install.sh
#
#./root_install.sh <version>
#
# ./root_install.sh 
#
#      <version> format
# ROOT version 00 . sub 00 . patch  00 (if applicable)
#        .   6    .   08   . 06

############################
####
#### For root v6 +
##########################
version=$1
origdir=`dirname $0`

cd /scratch/
mkdir -p applications
cd applications

echo "Downloading root_v${version}.tar.gz..."
until test -f root_v${version}.source.tar.gz
do wget https://root.cern.ch/download/root_v${version}.source.tar.gz
done

echo "Unpacking root_v${version}.tar.gz..."
until test -d root-${version}
do tar -zxvf root_v${version}.source.tar.gz
done

mv root root-${version}

mkdir -p root-${version}-build
mkdir -p root-${version}-install
cd root-${version}-build


# Fix for incorrect library name when you dont have admin access to fix
# with simple symbolic linking... yeah that
# normally 
# ln -s /path/to/oracale-instaclient/12.1/lib/libclntsh.so.12.1 /path/to/oracale-instaclient/12.1/lib/libclntsh.so
# would fix it
echo "Configuring root-${version}..."
cmake -DCMAKE_INSTALL_PREFIX=../root-${version}-install \
 -Dbuiltin_fftw3=ON \
 -Dgdml=ON \
 -Dgeocad=ON \
 -Dminuit2=ON \
 -Dmt=ON \
 -Droofit=ON \
 -Dunuran=ON \
 -Dmathmore=ON \
 -Dpython=ON\
 -DORACLE_LIBRARY_CLNTSH=/opt/ORACLErdbms/12.1/lib/libclntsh.so.12.1 \
 -DORACLE_LIBRARY_OCCI=/opt/ORACLErdbms/12.1/lib/libocci.so.12.1 \
 -DORACLE_LIBRARY_LNNZ=/opt/ORACLErdbms/12.1/lib/libnnz12.so \
 ../root-${version}

j=`cat /proc/cpuinfo | grep processor | wc -l`
echo "Make will use $j parallel jobs."

echo "Building ROOT ${version}..."
make -j $j

echo "Installing ROOT ${version}..."
make install



cd "${origdir}"

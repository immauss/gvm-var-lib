#!/bin/bash
# This is a simple script to pre-populate your docker managed volume with 
# SCAP/CERT/NVT/GVM data.
# You'll need to run it from the directory with the var-lib.tar.xz 
# This "should" work in any docker environment, but I've only 
# tested it with Docker Desktop on MacOS.
# And should be a little faster than syncing everything from scratch.
# The directory structure used here is for my openvas docker image.
# https://github.com/immauss/openvas
# YMMV for other setups.
TARURL="https://github.com/immauss/gvm-var-lib/raw/main/var-lib.tar.xz"
if [ ! -x "$1" ]; then
	VOLUME="openvas"
else
	VOLUME="$1"
fi
echo -e "\tUsing $VOLUME as the container name. You can change this with:"
echo -e "\t\t$0 <container-name>\n\n"
if [ -f ./var-lib.tar.xz ]; then
	echo "No archive found. Would you like to download it now?"
	read junk
	if [ $junk == "Y" ] || [ $junk == "y" ] ; then
		curl --url $TARURL --output var-lib.tar.xz
	else
		echo "OK"
		exit
	fi
docker pull alpine 
docker run -d -v openvas-test:/data -v $(pwd)/mnt --name copypine alpine sleep 1d
docker exec -t $VOLUME sh -c "cd /data/; tar xvf /mnt/var-lib.tar.xz " 
docker rm -f copypine

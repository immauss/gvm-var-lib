# GVM-var-lib 
This is a repo just to make starting a new gvm setup a little faster.


 gvm-var-lib-pop.sh is a simple script to pre-populate your docker managed volume with 
 SCAP/CERT/NVT/GVM data.
 You'll need to run it from the directory with the var-lib.tar.xz 
 This "should" work in any docker environment, but I've only 
 tested it with Docker Desktop on MacOS.
 And should be a little faster than syncing everything from scratch.
 The directory structure used here is for my openvas docker image.
 https://github.com/immauss/openvas
 YMMV for other setups.


-Scott

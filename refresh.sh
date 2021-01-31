#!/bin/bash
# This script will refresh the data in the gvm-var-lib repo
# It will include a new db dump and the contents of /data/var-lib
# This should run from a cron with a long enough sleep to make sure
# the gvmd has updated the DB before creating the archive and pushing
# to github.
TWD="/tmp"
WD=$(pwd)
CNAME="openvas-base-data" # name of the container running for updates.
STIME="15m" # time between resync and archiving.

echo "Restart the container to force an update"
#docker restart $CNAME

cd $TWD
echo "First copy the feeds from the container"
docker cp ${CNAME}:/data/var-lib .
echo "Now dump the db from postgres"
docker exec -i $CNAME su -c "/usr/lib/postgresql/12/bin/pg_dump gvmd" postgres > ./base.sql 

echo "Compress and archive the data"
tar cJf var-lib.tar.xz var-lib
xz base.sql

echo "Do some cleanup"
mv var-lib.tar.xz $WD
mv base.sql.xz $WD

rm -rf var-lib
cd $WD
echo "All done!"
ls -l *.xz
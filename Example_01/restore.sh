#!/bin/bash



if [ $# -eq 0 ]
  then
    echo "Usage : $0 PG_SUFFIX_TO_RESTORE_FROM \n"
    exit 1
fi

. ./params.sh

PG_TO_RECOVER_SUFFIX=$1

./wait_for_user_key.sh

echo "Unmounting DATA and REDO file systems"
for i in $(echo ${MOUNT_POINT_LIST_SRC} | sed "s/,/ /g")
do
  echo "Unmounting $i"
  sudo umount "$i"
done

echo "Running df -h... make sure data and redo filesystems are unmounted before proceeding"
df -h

./wait_for_user_key.sh

echo "In case the database is on a VMware VM, then the datastore containing the database disks needs to be dismounted. "
echo "From vCenter, Remove Disks from DATA datastore from VM, and then unmount DATA datastore"

./wait_for_user_key.sh


ssh -l ${FA_USER} ${FLASH_ARRAY} purevol copy ${PG_NAME_DATA_SRC}.${PG_TO_RECOVER_SUFFIX}.ds-oracle-appl-aa-data ds-oracle-appl-aa-data --overwrite

./wait_for_user_key.sh

echo "In case the database is on a VMware VM, then the datastore needs to be mounted at this point. "
echo "From vCenter, Mount DATA datastore, and add back disks from DATA datastore to the VM... Select Add Existing Hard Disk option "

echo "Press Enter only after the datastore is mounted"

./wait_for_user_key.sh

echo "Mounting DATA and REDO file systems"

for i in $(echo ${MOUNT_POINT_LIST_SRC} | sed "s/,/ /g")
do
  echo "Mounting $i"
  sudo mount "$i"
done

echo "Running df -h... make sure data and redo filesystems are mounted before proceeding"

df -h

echo "Restore Redo and Control files from mirrored copy available in FRA"

./wait_for_user_key.sh

#cp /mnt/applaa/fra/APPLA/onlinelog/redo01.log /mnt/applaa/redo/APPLA/o1_mf_1_j076816s_.log
#cp /mnt/applaa/fra/APPLA/onlinelog/redo02.log /mnt/applaa/redo/APPLA/o1_mf_2_j076817n_.log
#cp /mnt/applaa/fra/APPLA/onlinelog/redo03.log /mnt/applaa/redo/APPLA/o1_mf_3_j0768183_.log
#cp /mnt/applaa/fra/APPLA/controlfile/o1_mf_j0767ywn_.ctl /mnt/applaa/data/APPLA/controlfile/o1_mf_j0767yw0_.ctl

echo "Now database will be mounted and recovery will start"

./wait_for_user_key.sh

rman target / @recover_db.sql


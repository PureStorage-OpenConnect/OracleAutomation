#!/bin/bash

## ssh should be setup for password less login
## on the target, os login user should have its profile set in .bashrc (non-interactive login) 



# Site-Specific

export ORACLE_DBNAME_SRC=oraprd12
export ORACLE_SID_SRC=oraprd12
export ORACLE_BASE_SRC=/u01/app/oracle
export ORACLE_HOME_SRC=/u01/app/oracle/product/19.0.0/dbhome_1


export ORACLE_DBNAME_TGT=oraprd12
export ORACLE_SID_TGT=oraprd12
export ORACLE_BASE_TGT=/u01/app/oracle
export ORACLE_HOME_TGT=/u01/app/oracle/product/19.0.0/dbhome_1

export DB_HOST_SRC=10.0.0.12
export DB_HOST_TGT=10.0.0.11

export DB_HOST_USER_SRC=oracle
export DB_HOST_USER_TGT=oracle

export DB_HOST_GI_USER_SRC=grid
export DB_HOST_GI_USER_TGT=grid

export DB_PORT_SRC=1521
export DB_PORT_TGT=1521

export DB_USER_SRC=system
export DB_USER_TGT=system

export DB_PASS_SRC=oracle
export DB_PASS_TGT=oracle


export FLASH_ARRAY=10.0.0.110
export FA_USER=pureacc22

export PG_NAME_SRC=oraprd12-pod::oraprd12-pg
export PG_NAME_TGT=oraprd12-pg

export MOUNT_POINT_LIST_SRC="ORAPRD12_DATA,ORAPRD12_FRA,ORAPRD12_REDO"
export MOUNT_POINT_LIST_TGT="ORAPRD12_DATA,ORAPRD12_FRA,ORAPRD12_REDO"

export FA_VOL_SUFFIX=-h11



echo ""
echo "+-------------------------------------------------------------------------------+"
echo "| Print banner and list high level steps - Demo only                            |"
echo "+-------------------------------------------------------------------------------+"
echo ""

./banner_stime.sh


echo ""
echo "+-------------------------------------------------------------------------------+"
echo "| Shutdown target database if it is up.                                         |"
echo "+-------------------------------------------------------------------------------+"
echo ""

sdate=$(date +"%s")

./shutdown.sh 



echo ""
echo "+-------------------------------------------------------------------------------+"
echo "| Insert validation record into Source database table                           |"
echo "+-------------------------------------------------------------------------------+"
echo ""


./ins_rec.sh


echo ""
echo "+-------------------------------------------------------------------------------+"
echo "|   Unmount Disk Groups (${MOUNT_POINT_LIST_TGT}) on the Target Host            |"
echo "+-------------------------------------------------------------------------------+"
echo ""


./umount_asm.sh



echo ""
echo "+-------------------------------------------------------------------------------+"
echo "|  Take the snapshots and copy them to volumes on the array                     |"
echo "+-------------------------------------------------------------------------------+"
echo ""

fasdate=$(date +"%s")
./pure_snap.sh
faedate=$(date +"%s")


echo ""
echo "+-------------------------------------------------------------------------------+"
echo "|   Mount Disk Groups (${MOUNT_POINT_LIST_TGT}) on Target Host                  |"
echo "+-------------------------------------------------------------------------------+"
echo ""


./mount_asm.sh


echo ""
echo "+-------------------------------------------------------------------------------+"
echo "|  Start up the cloned database                                                 |"
echo "+-------------------------------------------------------------------------------+"
echo ""

./startup.sh


edate=$(date +"%s")


echo ""
echo "+-------------------------------------------------------------------------------+"
echo "|  Check validation record for the correct timestamp                            |"
echo "+-------------------------------------------------------------------------------+"
echo ""


./show_rec.sh

echo ""
echo ""

ddiff=$(($edate-$sdate))
echo "Total Time               : $(($ddiff / 60)) minutes and $(( $ddiff % 60 )) seconds"

faddiff=$(($faedate-$fasdate))
echo "Total Time on FlashArray : $(($faddiff / 60)) minutes and $(( $faddiff % 60 )) seconds"

echo ""
echo "End of demo!!"



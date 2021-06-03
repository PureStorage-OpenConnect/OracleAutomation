#!/bin/bash

# Run the environment/parameter file
. ./params.sh

# Place the database in begin backup mode
sqlplus / as sysdba @begin_backup

TODATE=`date +%Y-%m-%d-%H%M%S`
SUFFIX=DEMO-$TODATE

# Take a snapshot of the DATA Protection Group on the FlashArray. 
echo "Executing cmd on FLASH_ARRAY : ssh -l ${FA_USER} ${FLASH_ARRAY} purepgroup snap --suffix $SUFFIX ${PG_NAME_DATA_SRC}"
ssh -l ${FA_USER} ${FLASH_ARRAY} purepgroup snap --suffix $SUFFIX ${PG_NAME_DATA_SRC}

# Snapshot is taken, the database can be taken out of Backup mode
sqlplus / as sysdba @end_backup

# Take a snapshot of the FRA Protection Group on the FlashArray. 
echo "Executing cmd on FLASH_ARRAY : ssh -l ${FA_USER} ${FLASH_ARRAY} purepgroup snap --suffix $SUFFIX ${PG_NAME_FRA_SRC}"
ssh -l ${FA_USER} ${FLASH_ARRAY} purepgroup snap --suffix $SUFFIX ${PG_NAME_FRA_SRC}

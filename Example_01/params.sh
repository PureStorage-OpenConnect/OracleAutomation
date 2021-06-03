
# Environment Variables
export ORACLE_SID=appla
export ORACLE_HOME=/u01/app/oracle/product/19.0.0/dbhome_1
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH

export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch


# Parameters
export FLASH_ARRAY=10.1.1.11
export FA_USER=pureappl

export PG_NAME_DATA_SRC=appla-data-pg
export PG_NAME_FRA_SRC=appla-fra-pg

export MOUNT_POINT_LIST_SRC="/mnt/applaa/data,/mnt/applaa/redo"
export MOUNT_POINT_LIST_FRA="/mnt/applaa/fra"

export WAIT_FOR_USER=0
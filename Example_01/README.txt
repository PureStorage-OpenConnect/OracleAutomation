These example scripts demonstrate how to automate backup and restore of an Oracle database on a file system.


The scripts use ssh to connect to the FlashArray. If these scripts need to be non-interactively, then passwordless ssh needs to be set up. Instructions for configuring it are provided in passwordless-ssh-setup.pdf located in the Doc folder at the repository root level.




params.sh - Environment/Parameter file that gets called by other scripts.

            In addition to the environment variables that may need to be updated to match your configuration, the following env. variables need to be specified.

            FLASH_ARRAY          -   IP Address or FQDN of the FlashArray.
            FA_USER              -   FlashArray user that should be used to connect.
            PG_NAME_DATA_SRC     -   Protection Group that includes the "DATA" volumes
            PG_NAME_FRA_SRC      -   Protection Group that includes the "FRA" volumes
            MOUNT_POINT_LIST_SRC -   List of mount points for "DATA"
            MOUNT_POINT_LIST_FRA -   List of mount points for "FRA"
            WAIT_FOR_USER        -  Set this to a integer greater than 0 to get prompted for a key press as the scripts performs various steps



backup.sh - This script is the top level script that is run to take a backup of an Oracle database.  

  begin_backup.sql - This script is called by backup.sh to place the database in Hot Backup mode prior to taking database volume snapshots.

  end_backup.sql   - This script is called by backup.sh to take the database out of Hot Backup mode after taking database volume snapshots.


restore.sh - Execute this script to restore the snapshot backup of the database and perform the required steps to recover the database.
             
             Usage: restore.sh <Suffix of Protection Group snapshot that needs to be restored.> 

recover_db.sql - This SQL script is called by RMAN in restore.sh to startup mount the database, perform recovery and open the database.               




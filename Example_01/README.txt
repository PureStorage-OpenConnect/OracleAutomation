These example scripts demonstrate how to automate backup and restore of an Oracle database on a file system.


The scripts use ssh to connect to the FlashArray. If these scripts need to be non-interactively, then passwordless ssh needs to be set up. Instructions for configuring it are provided in passwordless-ssh-setup.pdf located in the Doc folder at the repository root level.




params.sh - Environment/Parameter file that gets called by other scripts.

backup.sh - This script is the top level script that is run to take a backup of an Oracle database.  

  begin_backup.sql - This script is called by backup.sh to place the database in Hot Backup mode prior to taking database volume snapshots.

  end_backup.sql   - This script is called by backup.sh to take the database out of Hot Backup mode after taking database volume snapshots.


restore.sh



restore_latest_PG_snapshot.sh



Other utility scripts 

kill_db.sh - Shutdown the database and delete database files to simulate a disaster event
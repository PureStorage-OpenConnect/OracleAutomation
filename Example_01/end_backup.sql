alter database end backup;

alter system archive log current;

alter database backup controlfile to '/mnt/applaa/fra/APPLA/controlfile/controlfile.bck' reuse;

-- Select sequence#,FIRST_CHANGE#,NEXT_CHANGE# from v$archived_log where FIRST_CHANGE# >=(Select CURRENT_SCN from v$database) and NEXT_CHANGE# <= (Select CURRENT_SCN from v$database);

exit



clear
echo "                        /------------------------\                       "
echo "                       /++++++++++++++++++++++++++\                      "
echo "                      /++++++++++++++++++++++++++++\                     "
echo "                     /++++++++++++++++++++++++++++++\                    "
echo "                    /++++++++++++++++++++++++++++++++\                   "
echo "                   /++++++++++++/---------\+++++++++++\                  "
echo "                  /++++++++++++/           \+++++++++++\                 "
echo "                 /++++++++++++/             \+++++++++++\                "
echo "                /++++++++++++/               \+++++++++++\               "
echo "               /++++++++++++/                 \+++++++++++\              "
echo "               \++++++++++++\                 /+++++++++++/              "
echo "                \++++++++++++\               /+++++++++++/               "
echo "                 \++++++++++++\             /+++++++++++/                "
echo "                  \++++++++++++\           /+++++++++++/                 "
echo "                   \++++++++++++\         /-----------/                  "
echo "                    \++++++++++++\                                       "
echo "                     \++++++++++++\                                      "
echo "                      \++++++++++++\                                     "
echo "                       \++++++++++++\                                    "
echo "                        \------------\                                   "
echo " "
echo " "
echo "           Oracle Database Cloning Demo using Pure Snapshot              "
echo " "
echo "            Rapid Clone - Clone Database on Target server  "
echo "  "
echo "    +---------------------------------+        +---------------------------------+   "
echo "    |           Source DB             |        |           Target DB             |  "
echo "    |                                 |        |                                 |  "
echo "    |       Hostname: $DB_HOST_SRC   |  ===>  |        Hostname: $DB_HOST_TGT  |  "
echo "    |       Database: $ORACLE_DBNAME_SRC             |  ===>  |        Database: $ORACLE_DBNAME_TGT            |  "
echo "    |                                 |        |                                 |  "
#echo "    | Location: /u02/oradata/prod     |        | Location: /u02/oradata/dev      |"
#echo "    | Location: /u03/oradata/prod     |        | Location: /u03/oradata/dev      |"
#echo "    | Location: /u04/oraredo/prod     |        | Location: /u04/oraredo/dev      |"
echo "    +---------------------------------+        +---------------------------------+  "
echo " "
echo " "
echo " "
read -p "Press Enter to continue" key
clear
echo " "
echo " High level Steps "
echo " "
echo " 1. Shutdown Target database ${ORACLE_DBNAME_TGT} on host ${DB_HOST_TGT} "
echo " "
echo " 2. Insert record into Source DB for validation "
echo " "
echo " 3. Unmount the Disk Groups on target server (if mounted)"
echo " "
echo " 4. Take snapshot of the source Protection Group on Pure"
echo " "
echo " 5. Copy target volumes from Source snapshot"
echo " "
echo " 6. Mount the Disk Groups on target server"
echo " "
echo " 7. Open the database"
echo " "
echo " 8. Validate the records on cloned database "
echo " "
echo " "
echo " "
read -p "Press Enter to continue" key
clear

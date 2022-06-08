SUFFIX=`date +%Y-%m-%d-%H%M%S`


echo ""
echo "Executing cmd on FLASH_ARRAY : ssh -l ${FA_USER} ${FLASH_ARRAY} purepgroup snap --suffix DEMO-$SUFFIX ${PG_NAME_SRC}"
echo ""

echo ""
ssh -l ${FA_USER} ${FLASH_ARRAY} purepgroup snap --suffix DEMO-$SUFFIX ${PG_NAME_SRC}
echo ""

echo "Executing cmd on FLASH_ARRAY : ssh -l ${FA_USER} ${FLASH_ARRAY} purevol list --notitle --csv --snap ${PG_NAME_SRC}.DEMO-${SUFFIX}*"

ssh -l ${FA_USER} ${FLASH_ARRAY} purevol list --notitle --csv --snap ${PG_NAME_SRC}.DEMO-${SUFFIX}* | while read line
do
        SNAP=`echo $line | cut -d "," -f1`
        #echo "SNAP = $SNAP"
        TARG=`echo ${SNAP/ebiz02/ebiz04} | cut -d "." -f3`
        TARG=${TARG}${FA_VOL_SUFFIX}
        #echo "TARG = $TARG"
        echo "ssh -l ${FA_USER} ${FLASH_ARRAY} purevol copy --overwrite $SNAP $TARG < /dev/null"
        ssh -l ${FA_USER} ${FLASH_ARRAY} purevol copy --overwrite $SNAP $TARG < /dev/null
        echo ""
        echo ""
done

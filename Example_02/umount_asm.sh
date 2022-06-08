


for i in $(echo ${MOUNT_POINT_LIST_TGT} | sed "s/,/ /g")
do
  echo "ssh -l ${DB_HOST_GI_USER_TGT} ${DB_HOST_TGT} asmcmd umount $i -f"
  ssh -l ${DB_HOST_GI_USER_TGT} ${DB_HOST_TGT} asmcmd umount "$i" -f
done

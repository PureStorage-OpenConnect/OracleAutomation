#sudo mount /mnt/applaa/data
#sudo mount /mnt/applaa/redo
#sudo mount /mnt/applaa/fra
#

. ./params.sh

echo "Mounting Volumes"
for i in $(echo ${MOUNT_POINT_LIST_SRC} | sed "s/,/ /g")
do
  echo "Mounting $i"

  sudo mount "$i"
done

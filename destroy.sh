#!/bin/bash

unset DOMAIN
unset DIR
unset SUBDIR

SITE_STORAGE_BASE_PATH="/mnt/cloud-storage/sites/"
SITE_DATABASE_BASE_PATH="/mnt/cloud-database/sites/"
SUBDIR="/wp"

while [ -z ${DOMAIN} ]; do
  read -p "Enter domain name (without www.): `echo $'\n> '`" DOMAIN
done

DIR="${DOMAIN//./_}"

echo "Do you wish to backup database and files?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) sudo tar -zcf $(date +%F)_$DIR"_wp_db".tar.gz $SITE_DATABASE_BASE_PATH$DIR$SUBDIR; sudo tar -zcf $(date +%F)_$DIR"_wp_storage".tar.gz $SITE_STORAGE_BASE_PATH$DIR$SUBDIR; break;;
    No ) echo "Will not backup database and files..."; break;;
  esac
done

echo "Do you wish to remove stored database user password secret?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) docker secret rm $DIR"_wp_db_upw"; break;;
    No ) echo "Will not delete the stored secret..."; break;;
  esac
done

echo "Please remove the volume $DIR"_wp_www" within portainer."
echo "Please remove the volume $DIR"_wp_data" within portainer."


if [ -z "$(ls -A $SITE_DATABASE_BASE_PATH$DIR$SUBDIR)" ]; then
   sudo rm -rf $SITE_DATABASE_BASE_PATH$DIR$SUBDIR
fi

if [ -z "$(ls -A $SITE_STORAGE_BASE_PATH$DIR$SUBDIR)" ]; then
   sudo rm -rf $SITE_STORAGE_BASE_PATH$DIR$SUBDIR
fi

if [ -z "$(ls -A $SITE_DATABASE_BASE_PATH$DIR)" ]; then
   sudo rm -rf $SITE_DATABASE_BASE_PATH$DIR
fi

if [ -z "$(ls -A $SITE_STORAGE_BASE_PATH$DIR)" ]; then
   sudo rm -rf $SITE_STORAGE_BASE_PATH$DIR
fi
#!/bin/bash

git fetch --all && git reset --hard origin/master

unset DOMAIN
unset SITE_STORAGE_BASE_PATH
unset SITE_DATABASE_BASE_PATH
unset DIR
unset SUBDIR
unset STACK

while [ -z ${DOMAIN} ]; do
  read -p "Enter domain name (without www.): `echo $'\n> '`" DOMAIN
done

DIR="${DOMAIN//./_}"

export DOMAIN=$DOMAIN
export SITE_STORAGE_BASE_PATH="/mnt/cloud-storage/sites/"
export SITE_DATABASE_BASE_PATH="/mnt/cloud-database/sites/"
export DIR=$DIR
export SUBDIR="/wp"

echo "Do you wish to create the database user password secret?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) openssl rand -base64 20 | docker secret create $DIR"_wp_db_upw" -; break;;
    No ) echo "Will use existing secret..."; break;;
  esac
done

STACK="service-stack.yml"
echo "Which wordpress stack you want to deploy?"
select stack in "clean" "divi"; do
  case $stack in
    clean ) break;;
    divi ) STACK="service-stack-divi.yml" break;;
  esac
done

docker stack deploy -c $STACK $DIR"_wp"
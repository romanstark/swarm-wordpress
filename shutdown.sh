#!/bin/bash

unset DOMAIN
unset NAME
while [ -z ${DOMAIN} ]; do
  read -p "Enter domain name (without www.): `echo $'\n> '`" DOMAIN
done

NAME="${DOMAIN//./_}"
docker stack rm $NAME"_wp"
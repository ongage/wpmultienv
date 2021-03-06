#!/bin/bash

source .env
mkdir -p $MAINFOLDER/env1/db
mkdir -p $MAINFOLDER/env1/www
mkdir -p $MAINFOLDER/env2/db
mkdir -p $MAINFOLDER/env2/www
mkdir -p $MAINFOLDER/env3/db
mkdir -p $MAINFOLDER/env3/www
mkdir -p $MAINFOLDER/sftpdata
chown -R $HOSTUID:$HOSTGID /$MAINFOLDER/env1 /$MAINFOLDER/env2 /$MAINFOLDER/env3 /$MAINFOLDER/sftpdata
chown -R $ENV1UID:$ENV1GID /$MAINFOLDER/env1/www
chown -R $ENV2UID:$ENV2GID /$MAINFOLDER/env2/www
chown -R $ENV3UID:$ENV3GID /$MAINFOLDER/env3/www

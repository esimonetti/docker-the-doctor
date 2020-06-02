#!/bin/bash

# Enrico Simonetti
# enricosimonetti.com

image_name='ce-doctor'

echo Removing docker containers for image $image_name
docker ps -a | awk '{ print $1,$2 }' | grep $image_name | awk '{print $1 }' | xargs -I {} docker rm {}

echo Removing docker image $image_name
docker image rm $image_name

cd $( dirname ${BASH_SOURCE[0]} )
if [ -d ${PWD}/workdir/node_modules ]
then
    echo Cleaning previously locally installed node modules
    rm ${PWD}/workdir/package*json
    rm -rf ${PWD}/workdir/node_modules
fi

echo
echo Please note that ${PWD}/workdir and ${PWD}/homedir have not been removed! Proceed to delete them manually if you wish to do so
echo

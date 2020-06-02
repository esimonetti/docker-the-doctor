#!/bin/bash

# Enrico Simonetti
# enricosimonetti.com

image_name='ce-doctor'

if [ `command -v docker | grep docker | wc -l` -eq 0 ]
then
    echo Please install \"Docker\" before running this command
    exit 1
fi

cd $( dirname ${BASH_SOURCE[0]} )

# create local directories
if [ ! -d ${PWD}/homedir ]
then
    mkdir ${PWD}/homedir
    # chown the homedir accordingly as it contains secrets
    chmod -R 700 ${PWD}/homedir
fi
if [ ! -d ${PWD}/workdir ]
then
    mkdir ${PWD}/workdir
fi

if [ `docker images | awk '{ print $1 }' | grep $image_name | wc -l` -eq 0 ]
then
    echo Building image $image_name
    docker build -t $image_name .
else
    echo Leveraging existing image $image_name
fi

if [ ! -d ${PWD}/workdir/node_modules ]
then
    # install ce-util
    docker run --rm -v ${PWD}/workdir:/workdir -v ${PWD}/homedir:/root -t -i $image_name npm install ce-util
fi

if [ ! -d ${PWD}/homedir/.doctor/ -o ! -f ${PWD}/homedir/.doctor/config.json ]
then
    # init installation of ce-util
    echo Please retrieve your account\'s information, to initialise the system correctly
    docker run --rm -v ${PWD}/workdir:/workdir -v ${PWD}/homedir:/root -t -i $image_name node ./node_modules/ce-util/src/cli/doctor.js init

    # chown the homedir accordingly once again as it contains secrets
    chmod -R 700 ${PWD}/homedir
fi

if [ $# -eq 0 ]
then
    echo Provide The Doctor\'s argument\(s\) to run, as script arguments
    echo It might be beneficial to enclose the command within double quotes if it contains more than one word
    echo Examples:
    echo ./doctor.sh --help
    echo ./doctor.sh \"accounts list\"
    echo ./doctor.sh \"download formulas stage -d /workdir/formulas\"
    echo
    echo Remember that /workdir within the container is your local directory ${PWD}/workdir
    echo
else
    docker run --rm -v ${PWD}/workdir:/workdir -v ${PWD}/homedir:/root -t -i $image_name node ./node_modules/ce-util/src/cli/doctor.js $@
fi

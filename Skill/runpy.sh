#!/bin/bash -xv
#
# Script to test the low-level api (pythonscript)
# interactively
#
CRED_PATH=$1
CRED_FILE=$2
PICKLE=$3
MODE=$4

# get dir of current script:
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# CRED_PATH="$(cat ../config.ini | grep -Po '(?<=path_to_credentials=).*$')"
# CRED_FILE="$(cat ../config.ini | grep -Po '(?<=google_credentials_file=).*$')"
# PICKLE="$(cat ../config.ini | grep -Po '(?<=pickle_file=).*$')"

# start listener to start browser if necessary:
#
rm -f py.log
$DIR/authbrowser.sh &

stdbuf -o 0 python2 $DIR/googlegetevents.py $CRED_PATH $CRED_FILE $PICKLE $MODE > py.log

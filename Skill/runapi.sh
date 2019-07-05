#!/bin/bash -xv
#
# Script to test the low-level api (pythonscript)
# interactively
#

CRED_PATH="$(cat ../config.ini | grep -Po '(?<=path_to_credentials=).*$')"
CRED_FILE="$(cat ../config.ini | grep -Po '(?<=google_credentials_file=).*$')"
PICKLE="$(cat ../config.ini | grep -Po '(?<=pickle_file=).*$')"

python2 googlegetevents.py $CRED_PATH $CRED_FILE $PICKLE next4

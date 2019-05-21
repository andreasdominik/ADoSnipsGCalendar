#!/bin/bash -xv
#
# Script to test the low-level api (pythonscript)
# and write permissions in th file system.
#
# PY=$1
# PA=$2
# TOK=$3
# PIC=$4
# MOD=$5

echo "................"
echo "................"
cd /var/lib/snips/skills/ADoSnipsGCalendar/
pwd
ls -l > ll.txt
cat ll.txt
env
echo "................"
echo "................"

echo "................"
echo "................"
cd /var/lib/snips/skills/
pwd
ls -l > ll.txt
cat ll.txt
env
echo "................"
echo "................"
# python2 $1 . $3 $4 $5

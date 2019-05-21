#!/bin/bash -xv
#
# PY=$1
# PA=$2
# TOK=$3
# PIC=$4
# MOD=$5

cd /tmp
echo "................"
echo "................"
pwd
whoami
ls -l > ll.txt
echo "................"
echo "................"
cat ll.txt
env
echo "................"
echo "................"

python2 $1 . $3 $4 $5

#!/bin/bash -xv
#
#
sleep 5
grep "Please visit this URL" py.log
RESULT=$?

# open a browser window if this line is in the log:
#
if [[ RESULT -eq 0 ]] ; then
  URL="$(grep 'Please visit this URL' py.log | sed 's/Please visit this URL to authorize this application: //')"
  DISPLAY=:0 chromium-browser "$URL" &
  PID=$!
  sleep 2
  kill -9 $PID
fi

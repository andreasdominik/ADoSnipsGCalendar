#!/bin/bash -xv
#
# open chromium browser and the authentication site
# to generate new pickle.
#
GOOGLE_LOG="gcal.log"
sleep 2

if test -e $GOOGLE_LOG ; then
  grep "Please visit this URL " $GOOGLE_LOG
  RESULT=$?

  # strat browser, if message found:
  #
  if [[ $RESULT -eq 0 ]] ; then
    URL="$(cat $GOOGLE_LOG | sed 's/Please visit this URL to authorize this application: //g')"
    DISPLAY=:0 chromium_browser "$URL" &
    CHROMIUM_PID=$!
    sleep 2
    kill -9 $CHROMIUM_PID
  fi
fi

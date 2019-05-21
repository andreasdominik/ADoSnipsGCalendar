#
# API function goes here, to be called by the
# skill-actions:
#
"""
    function getGoogleCalendar(mode)

Calls a Python2 script to retrieve events from the google calendar,
spec. by credentials file.

if something is not working, false is retrurned, else true and a json file
with events.
"""
function getGoogleCalendar(mode)

    PATH = Snips.getConfig(INI_CREDENTIALS_PATH)
    TOKEN = Snips.getConfig(INI_GOOGLE_CREDENTIALS)
    PICKLE = Snips.getConfig(INI_PICKLE)

    #shell = `python2 $PYTHON_SCRIPT $PATH $TOKEN $PICKLE $mode`
    # for testing only:
    shell = `$RUNNER_SCRIPT $PYTHON_SCRIPT $PATH $TOKEN $PICKLE $mode`

    return Snips.tryrun(shell, wait = true, errorMsg = TEXTS[:error_gcal])
end

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

    mypwd = read(`pwd`, String)
    myll = read(`ls -al`, String)
    myi = read(`whoami`, String)
    mycreds = read(`ls -al -a $PATH`, String)
    println("pwd: $mypwd")
    println("ll: $myll")
    println("credsll: $mycreds")
    println("me: $myi")

    shell = `cd /tmp; python2 $PYTHON_SCRIPT $PATH $TOKEN $PICKLE $mode`
    #shell = `$RUNNER_SCRIPT $PYTHON_SCRIPT $PATH $TOKEN $PICKLE $mode`

    return Snips.tryrun(shell, wait = true,
        errorMsg = "Sorry! I could not connect to the Google calendar")
end

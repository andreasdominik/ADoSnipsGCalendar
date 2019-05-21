
# language settings:
# 1) set LANG to "en", "de", "fr", etc.
# 2) link the Dict with messages to the version with
#    desired language as defined in languages.jl:
#

lang = Snips.getConfig(:language)
const LANG = (lang != nothing) ? lang : "de"

# DO NOT CHANGE THE FOLLOWING 3 LINES UNLESS YOU KNOW
# WHAT YOU ARE DOING!
# set CONTINUE_WO_HOTWORD to true to be able to chain
# commands without need of a hotword in between:
#
const CONTINUE_WO_HOTWORD = true
const DEVELOPER_NAME = "andreasdominik"
Snips.setDeveloperName(DEVELOPER_NAME)
Snips.setModule(@__MODULE__)

# Filenames:
#
const CALENDAR_JSON = "/tmp/googleevents.json"
const PYTHON_SCRIPT = "$MODULE_DIR/googlegetevents.py"
const RUNNER_SCRIPT = "$MODULE_DIR/runapi.sh"

# Slots:
# Name of slots to be extracted from intents:
#
const SLOT_MODE = "mode"

# name of entry in config.ini:
#
const INI_CREDENTIALS_PATH = "path_to_credentials"
const INI_GOOGLE_CREDENTIALS = "google_credentials_file"
const INI_PICKLE = "pickle_file"

#
# link between actions and intents:
# intent is linked to action{Funktion}
# the action is only matched, if
#   * intentname matches and
#   * if the siteId matches, if site is  defined in config.ini
#     (such as: "switch TV in room abc").
#
# Language-dependent settings:
#
if LANG == "de"
    Snips.registerIntentAction("ReadGoogleCalendarDE", googleCalendar)
    TEXTS = TEXTS_DE
elseif LANG == "en"
    Snips.registerIntentAction("ReadGoogleCalendarEN", googleCalendar)
    TEXTS = TEXTS_EN
else
    Snips.registerIntentAction("ReadGoogleCalendarDE", googelCalendar)
    TEXTS = TEXTS_DE
end

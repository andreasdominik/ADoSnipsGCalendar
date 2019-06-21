# ADoSnipsGCalendar

Skill to access the GoogleCalendar from Snips home assistant.
Supported languages include only *German* at the moment.

The code is written in Julia and based on the Template for the
SnipsHermesQnD framework for Snips.ai

For the full documentation see the Template repo on github:

 [Template for Julia skill](https://github.com/andreasdominik/ADoSnipsTemplate)

 [Framework documentation](https://andreasdominik.github.io/ADoSnipsTemplate/dev)


## Google calendar access

The Google can be accessed using so-called OAuth 2.0 authorisation.
Please visit the documentation of the
[Calendar API](https://developers.google.com/calendar/overview)
for details about enabling the API and accessing it.
The calendar access is implemented using the Python API (because the API
handles all the ado with access tokens and refresh tokens). Therefore  
the client library must be installed in the Snips device (the Raspberry Pie)
as describend here
[Python Calendar API](https://developers.google.com/calendar/quickstart/python)
(it seems the way with `easy_install` works on a Pie out of the box).

It is recommended to run the Python script standalone (from the commandline)
for the first time,
because there is a user interaction necessary at the first call.
The first API-call also generates the refresh-token that is used by
the API to refresh the access token if it gets expired (the pickle file).

## Google credentials

Please move the credentials file (`credentials.json`)
to a secure place in the file system (such as
`/opt/Snips/ADoSnipsCalendar/Credentials/`) and make the
files readable for the Snips services.
Then provide path and filename in respective lines of the
`config.ini`.

Make sure that the files are **not** in the Git repository, because
everybody with this credentials will have access to your calendar.


# Julia

This skill is (like the entire SnipsHermesQnD framework) written in the
modern programming language Julia (because Julia is faster
then Python and coding is much much easier and much more straight forward).
However "Pythonians" often need some time to get familiar with Julia.

If you are ready for the step forward, start here: https://julialang.org/


# Configuration

The file `config.ini` provides the path to the Google credentials information:
```
[global]
language=de
[secret]
path_to_credentials=/opt/Snips/ApplicationData/ADoSnipsCalendar/Credentials
google_credentials_file=credentials.json
pickle_file=token.pickle
```

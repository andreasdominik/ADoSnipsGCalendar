from __future__ import print_function
import datetime
import pickle
import sys
import os.path
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

# If modifying these scopes, delete the file token.pickle.
SCOPES = ['https://www.googleapis.com/auth/calendar.readonly']


def getNext4(service):
    """
    Prints the start and name of the next 4 events on the user's calendar.
    """
    now = datetime.datetime.utcnow().isoformat() + 'Z' # 'Z' indicates UTC time
    print('Getting the upcoming 4 events')
    events_result = service.events().list(calendarId='primary', timeMin=now,
    maxResults=4, singleEvents=True,
    orderBy='startTime').execute()
    events = events_result.get('items', [])
    return events




def getOneDay(service, day):
    """
    Prints the start and name of one day's events on the user's calendar.
    """
    #now = datetime.datetime.utcnow().isoformat() + 'Z' # 'Z' indicates UTC time
    minTime = '{}T00:00:00.000000Z'.format(day)
    maxTime = '{}T23:59:59.000000Z'.format(day)

    print('Getting the todays events')
    events_result = service.events().list(calendarId='primary',
    timeMin=minTime, timeMax=maxTime,
    maxResults=4, singleEvents=True,
    orderBy='startTime').execute()

    events = events_result.get('items', [])
    return events

def writeJSON(events, day):
    """writes the event to a json file"""
    json = '/tmp/googleevents.json'


    if not events:
        print('No upcoming events found.')
        with open(json, 'w') as f:
            f.write('{')
            f.write('  "num events" : 0')
            f.write('}')
    else:
        num = len(events)
        with open(json, 'w') as f:
            f.write('{\n')
            f.write('  "num events" : '); f.write(str(num)); f.write(',\n')

            if day:
                f.write('  "day" : "'); f.write(day.strftime('%a %d %b %Y')); f.write('",\n')

            f.write('  "events" :\n')
            f.write('  [\n')
            for i,event in enumerate(events):
                i += 1
                start = event['start'].get('dateTime', event['start'].get('date'))
                # print(start, event['summary'])
                f.write('    {\n')
                f.write('       "time" : "'); f.write(start); f.write('",\n')
                f.write('       "description" : "'); f.write(event['summary'].encode('utf-8')); f.write('"\n')
                if i < num:
                    f.write('     },\n')
                else:
                    f.write('     }\n')

            f.write('  ]\n')
            f.write('}\n')




def main():
    """Get token and login using OAuth2"""

    credentialsDir = sys.argv[1]
    credentialsFile = credentialsDir + '/' + sys.argv[2]
    pickleFile = '/tmp/' + sys.argv[3]
    query = sys.argv[4]  # one of next4, today

    creds = None
    # The file token.pickle stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    if os.path.exists(pickleFile):
        with open(pickleFile, 'rb') as token:
            creds = pickle.load(token)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                credentialsFile, SCOPES)
            creds = flow.run_local_server()
        # Save the credentials for the next run
        with open(pickleFile, 'wb') as token:
            pickle.dump(creds, token)

    service = build('calendar', 'v3', credentials=creds)

    # Call the Calendar API
    day = False
    if query == 'next4':
        events = getNext4(service)
    elif query == 'tomorrow':
        day = datetime.date.today() + datetime.timedelta(days=1)
        events = getOneDay(service, day)
    else:
        day = datetime.date.today()
        events = getOneDay(service, day)


    writeJSON(events, day)

if __name__ == '__main__':
    main()


    def getToday(service):
        today = datetime.date.today()
        return getOneDay(service, today)


        def getTomorrow(service):
            tomorrow = datetime.date.today() + datetime.timedelta(days=1)
            return getOneDay(service, tomorrow)

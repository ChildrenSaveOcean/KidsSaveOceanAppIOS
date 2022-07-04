#!/opt/homebrew/bin/python3
# -*- coding: utf-8 -*-

import argparse
import json
import requests
import re

parser = argparse.ArgumentParser(
                                 description='''<<< Script for sending push notification for project Kids Save Ocean >>>''',
                                 epilog="""Usage example: ./send_push_notification.py --target 3 --title 'Hello, ocean!' --text 'Exciting news are coming!' --time_to_live '1d' --broadcast 1""")

parser.add_argument('--target', type=int, help='Target is a final code word for processing notification in the mobile application.Target can be \
                    PolicyChange (print 0), ActionAlert (print 1), NewsAndMedia (print 2), NewHighScore (print 3), SignatureCompaign (print 4)')

parser.add_argument('--title', type=str, help='Title is a title of notification message, will be shown on the top of the notification badge')
parser.add_argument('--text', type=str, help='Notificatin main message')

parser.add_argument('--device', nargs='?', help='Optional parameter. Put here the device token for sending the notification directly to this device')
parser.add_argument('--time_to_live', nargs='?', help='Optional parameter, print 4d or 2w or 1h or 30s or 5m (min) of actual time the notification. The maximum is 4w or 28d')
parser.add_argument('--broadcast', nargs='?', help='Optional parameter, just call it with any argument for sending notification for all registered deiveces.')
parser.add_argument('--link', nargs='?', help='Optional parameter, type link which is supposed to be open by user.')


args = parser.parse_args()

targets = [ "PolicyChange", "ActionAlert", "NewsAndMedia", "NewHighScore", "SignatureCampaign" ]
time_units = {"w": 604800, "d": 86400, "m": 60, "h": 3600, "s": 1}

device_token = ""
api_access_key = "DON't FORGET TO ADD API ACCESS KEY FROM Firebase Console Project Settings"
url = "https://fcm.googleapis.com/fcm/send"

# time to live - expiration time
time_to_live = 0
if args.time_to_live is not None:
    time_to_live_parsed = re.findall("(\d+)([a-zA-Z])", args.time_to_live)
    
    if len(time_to_live_parsed) > 0 and len(time_to_live_parsed[0]) > 1 and time_to_live_parsed[0][0] is not None and time_to_live_parsed[0][1] is not None:
        
        time_long_str = time_to_live_parsed[0][0]
        time_long = int(time_long_str)
        
        time_unit = time_to_live_parsed[0][1]
        if time_units[time_unit] is not None:
            time_to_live = time_long * int(time_units[time_unit])

# to whom send the notification - one device for test or for all devices which have installed the application
to = args.device if args.device is not None else device_token
if args.broadcast:
    to = "/topics/all"

headers = { "Authorization" : "key=" + api_access_key,
            "content-type" : "application/json"}
params = {  "grant_type" : "client_credentials" }

jsonAgrs = {}
print("sending notification " + targets[args.target])
jsonAgrs["data"] = {"target": targets[args.target]}
if args.link is not None:
    jsonAgrs["data"]["link"] = args.link

jsonAgrs["to"] = to
jsonAgrs["content_available"] = bool(True)
jsonAgrs["priority"] = "normal"
jsonAgrs["notification"] =  { "body" : args.text,
                              "title": args.title,
                              "badge": 1,
                              "sound": bool(True)
                              }
if time_to_live > 0:
    jsonAgrs["notification"]["time_to_live"] = time_to_live

res = requests.post(url, headers=headers, params=params, data=json.dumps(jsonAgrs))
print(res)
print(res.text)
print("\n\n")



#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Code
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ✉️
# @raycast.packageName Message

# Documentation:
# @raycast.description Copy verification code from a message
# @raycast.author Ssssv

result=$(sqlite3 /Users/houjuncai/Library/Messages/chat.db 'SELECT text FROM message WHERE datetime(date/1000000000 + 978307200,"unixepoch","localtime") > datetime("now","localtime","-60 second") ORDER BY date DESC LIMIT 1;')

name="验证码";

if [ ! $result ]; then
  echo "No verification code received in the last 60 seconds!"
  exit 0;
fi

if [[ "$result" =~ "$name" ]]; then
  code=`echo $result | grep -o "[0-9]\{4,6\}"`;
  
  echo "$code" | pbcopy;
  echo "$code Code copied!"
fi




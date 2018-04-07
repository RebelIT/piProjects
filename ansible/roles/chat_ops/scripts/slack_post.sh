#!/bin/bash
#./slackpost.sh "text to post"

webhook_url="{{ slack_notification }}"
username="{{ slack_username }}"
icon_url="{{ slack_icon_url }}"

text=$1
if [[ $text == "" ]]
then
        echo "No text specified"
        exit 1
fi

formatted_text=$(echo $text | sed 's/"/\"/g' | sed "s/'/\'/g" )
json="{
      \"text\": \"$formatted_text\",
      \"username\":\"$username\",
      \"icon_url\":\"$icon_url\"
    }"

curl -s -d "payload=$json" "$webhook_url"

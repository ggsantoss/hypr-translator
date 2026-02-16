#!/bin/zsh

TEXT=$(wl-paste --primary)

if [ -z "$TEXT" ]; then
    exit 0
fi

ENCODED=$(printf "%s" "$TEXT" | jq -sRr @uri)

RESPONSE=$(curl -s \
"https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=pt&dt=t&q=$ENCODED")

TRANSLATION=$(echo "$RESPONSE" | jq -r '.[0][0][0]')

if [ -z "$TRANSLATION" ] || [ "$TRANSLATION" = "null" ]; then
    notify-send "Translation Error" "Failed to translate"
else
    notify-send "Translation" "$TRANSLATION"
fi
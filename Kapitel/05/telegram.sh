#!/bin/bash

# Zugriff zur Telegram-API
API_KEY="965679143:AAGI-DmoZ2xznh717dceq-emdC9a1xRG7MS"
CHAT_ID=271714768

MESSAGE="$@"

# Nachricht an Telegram senden
/usr/bin/curl --silent --ipv4 \
  --data "chat_id=$CHAT_ID&text=$HOSTNAME:+$MESSAGE" \
  https://api.telegram.org/bot$API_KEY/sendMessage >/dev/null

#!/bin/bash

# Configuration
REMOTE_USER="user"
REMOTE_HOST="remote.host.com"
PROCESS_NAME="your_process_name"
EMAIL_TO="you@example.com"
EMAIL_SUBJECT="Process Check Status: $PROCESS_NAME on $REMOTE_HOST"

# Check if the process is running remotely
STATUS=$(ssh -o ConnectTimeout=10 "${REMOTE_USER}@${REMOTE_HOST}" "pgrep -fl '${PROCESS_NAME}'")

# Prepare the message
if [[ -n "$STATUS" ]]; then
    MESSAGE="✅ The process '${PROCESS_NAME}' is running on ${REMOTE_HOST}.\n\nDetails:\n$STATUS"
else
    MESSAGE="❌ The process '${PROCESS_NAME}' is NOT running on ${REMOTE_HOST}."
fi

# Send the email
echo -e "$MESSAGE" | mail -s "$EMAIL_SUBJECT" "$EMAIL_TO"

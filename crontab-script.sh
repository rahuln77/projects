#!/bin/bash

# Get current user's crontab
crontab -l 2>/dev/null | grep -v '^#' | grep -v '^\s*$' > /tmp/current_cron.txt

violation_found=0

echo "Checking for cron jobs scheduled between 07:00 and 19:00..."

while IFS= read -r line; do
    # Extract the first two fields: minute and hour
    minute=$(echo "$line" | awk '{print $1}')
    hour=$(echo "$line" | awk '{print $2}')

    # Check if hour is a number
    if [[ "$hour" =~ ^[0-9]+$ ]]; then
        if [ "$hour" -ge 7 ] && [ "$hour" -le 19 ]; then
            echo "Violation found: $line"
            violation_found=1
        fi
    elif [[ "$hour" =~ ^\*/[0-9]+$ || "$hour" == "*" ]]; then
        # Wildcards or ranges may include forbidden hours
        echo "Possible violation (complex schedule): $line"
        violation_found=1
    fi
done < /tmp/current_cron.txt

rm -f /tmp/current_cron.txt

if [ "$violation_found" -eq 0 ]; then
    echo "✅ No cron jobs found between 07:00 and 19:00."
else
    echo "⚠️ At least one cron job is scheduled between 07:00 and 19:00."
fi

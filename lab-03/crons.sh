#!/bin/sh

# Check for minimum number of arguments
if [ $# -lt 6 ]; then
    echo "Usage: $0 <minute> <hour> <day> <month> <weekday> <command> [args...]" >&2
    exit 1
fi

# Extract schedule and command
minute="$1"
hour="$2"
day="$3"
month="$4"
weekday="$5"
shift 5
cmd="$@"

# Create temporary file
tmpfile=$(mktemp) || exit 1

# Export current crontab
crontab -l > "$tmpfile" 2>/dev/null

# Append new cron job
echo "$minute $hour $day $month $weekday $cmd" >> "$tmpfile"

# Install new crontab
if crontab "$tmpfile"; then
    echo "Cron job added successfully." >&2
else
    echo "Failed to add cron job." >&2
    rm -f "$tmpfile"
    exit 1
fi

# Cleanup
rm -f "$tmpfile"
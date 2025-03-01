#!/bin/sh

# Validate arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 [no_files] [max_size]"
    echo "Example: $0 10 1GB"
    exit 1
fi

num_files=$1
max_size=$2

# Find files, filter by max_size, sort by size, and display the N smallest files
echo "Finding the $num_files smallest files under $max_size..."
echo "-----------------------------------------------------------"
echo "Size | Path"
echo "-----------------------------------------------------------"

# Add 'c' suffix to max_size if it doesn't have a suffix
if ! echo "$max_size" | grep -q '[bcwkMG]$'; then
    max_size="${max_size}c"
fi

find . -type f -size -"$max_size" -printf "%s %p\n" 2>/dev/null | sort -n | head -n "$num_files" | awk '{size=$1; $1=""; print size, $0}'

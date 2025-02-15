#!/bin/bash

clear_screen() {
  clear
}

show_last_15_lines() {
  echo "Showing the last 15 lines of 3 log files that contain general system activity data..."
  echo -e "\n/var/log/syslog\n"
  tail -n 15 /var/log/syslog
  echo -e "\n/var/log/auth.log\n"
  tail -n 15 /var/log/auth.log
  echo -e "\n/var/log/kern.log\n"
  tail -n 15 /var/log/kern.log
}

show_lines_containing_word() {
  echo "Filtering the last 15 lines of 3 log files to display only those containing a specific word..."
  read -p "Enter the word to filter: " word
  echo -e "\n/var/log/syslog\n"
  tail -n 15 /var/log/syslog | grep "$word"
  echo -e "\n/var/log/auth.log\n"
  tail -n 15 /var/log/auth.log | grep "$word"
  echo -e "\n/var/log/kern.log\n"
  tail -n 15 /var/log/kern.log | grep "$word"
}

while true; do
  clear_screen
  echo "1. Show the last 15 lines of 3 log files that contain general system activity data"
  echo "2. Filter those 15 lines from the same log files to display only those containing a specific word"

  echo -e "0. Exit \n"
  read -p "Enter your choice: " choice

  case "$choice" in
    0) break;;
    1) show_last_15_lines;;
    2) show_lines_containing_word;;
    *) echo "Invalid choice";;
  esac

  read -n 1 -r -p "Press any key to continue..."
done

echo "Exiting..."

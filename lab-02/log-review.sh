#!/bin/sh

clear_screen() {
  clear
}

show_last_15_lines() {
  echo "Showing the last 15 lines of 3 log files that contain general system activity data..."
  echo -e "\n/var/log/syslog\n"
  tail -n 15 /var/log/syslog | less
  echo -e "\n/var/log/cron\n"
  tail -n 15 /var/log/cron | less
  echo -e "\n/var/log/dmesg\n"
  tail -n 15 /var/log/dmesg | less
}

show_lines_containing_word() {
  echo "Filtering the last 15 lines of 3 log files to display only those containing a specific word..."
  read -p "Enter the word to filter: " word
  echo -e "\n/var/log/syslog\n"
  tail -n 15 /var/log/syslog | grep "$word" | less
  echo -e "\n/var/log/cron\n"
  tail -n 15 /var/log/cron | grep "$word" | less
  echo -e "\n/var/log/dmesg\n"
  tail -n 15 /var/log/dmesg | grep "$word" | less
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

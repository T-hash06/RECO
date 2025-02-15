#!/bin/sh

clear_screen() {
  clear
}

paginate_output() {
  if [ $(echo "$1" | wc -l) -gt 10 ]
  then
    echo "$1" | less
  else
    echo "$1"
  fi
}

prompt_for_directory() {
  read -p "Enter directory to analyze: " directory

  while [ ! -d "$directory" ]; do
    read -p "Directory does not exist. Please enter a valid directory: " directory
  done
}

prompt_for_directory

recursive="false"
recursive_text=""
recursive_option=""
response=""

while true; do
  clear_screen

  if [ $recursive = "true" ]
  then
    recursive_text=" (Recursive)"
    recursive_option="-R"
  else
    recursive_text=" (Not Recursive)"
    recursive_option=""
  fi
  
  echo -e "Directory: $directory$recursive_text\n"
  echo "1. Sort by most recent date (with count)"
  echo "2. Sort by oldest date (with count)"
  echo "3. Sort by size (largest to smallest, with count)"
  echo "4. Sort by size (smallest to largest, with count)"
  echo "5. Sort by file type (File/Directory, with count)"
  echo "6. Filter by filename (starts with)"
  echo "7. Filter by filename (ends with)"
  echo "8. Filter by filename (contains)"
  echo "9. Recursive search (include subdirectories)"
  echo "10. Change directory"
  echo -e "0. Exit\n"
  read -p "Enter your choice: " choice

  case "$choice" in
    1) response=$(ls $recursive_option -lat $directory); paginate_output "$response" ;;
    2) response=$(ls $recursive_option -lat $directory | tac); paginate_output "$response" ;;
    3) response=$(ls $recursive_option -lahS $directory); paginate_output "$response" ;;
    4) response=$(ls $recursive_option -lahS $directory | tac); paginate_output "$response" ;;
    5) response=$(ls $recursive_option -la $directory | sort); paginate_output "$response" ;;
    6) read -p "Enter filter string: " filter_string; \
        response=$(ls $recursive_option -la $directory | awk '{ if (NF >= 9 && $9 ~ /^'"$filter_string"'/) print }'); \
        paginate_output "$response" ;;
    7) read -p "Enter filter string: " filter_string; \
        response=$(ls $recursive_option -la $directory | awk '{ if (NF >= 9 && $9 ~ /'"$filter_string"'$/) print }'); \
        paginate_output "$response" ;;
    8) read -p "Enter filter string: " filter_string; \
        response=$(ls $recursive_option -la $directory | awk '{ if (NF >= 9 && $9 ~ /'"$filter_string"'/) print }'); \
        paginate_output "$response" ;;
    9) if [ "$recursive" = "true" ]
        then
          recursive="false"
          echo "Recursive search disabled $recursive"
        else
          recursive="true"
          echo "Recursive search enabled $recursive"
        fi ;;
    10) prompt_for_directory;;
    0) break;;
    *) echo "Invalid choice";;
  esac
  read -n 1 -r -p "Press any key to continue..."
done

echo "Exiting..."
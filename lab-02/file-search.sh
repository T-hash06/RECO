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

search_file() {
  read -p "Enter directory to search in: " directory
  read -p "Enter filename or part of it to search: " filename
  result=$(find "$directory" -type f -name "*$filename*")
  count=$(echo "$result" | wc -l)
  echo -e "Found $count occurrences:\n"
  paginate_output "$result"
}

search_word_in_file() {
  read -p "Enter file path: " file
  if [ ! -f "$file" ]; then
    echo "File does not exist."
    return
  fi
  read -p "Enter word or part of it to search: " word
  count=$(grep -n "$word" "$file" | wc -l)
  grep -n "$word" "$file"
  echo "Total occurrences: $count"
}

search_file_and_word() {
  read -p "Enter directory to search in: " directory
  read -p "Enter filename or part of it to search: " filename
  read -p "Enter word or part of it to search within found files: " word
  found_files=$(find "$directory" -type f -name "*$filename*")
  for file in $found_files; do
    echo -e "\nSearching in: $file"
    count=$(grep -n "$word" "$file" | wc -l)
    grep -n "$word" "$file"
    echo "Total occurrences: $count"
  done
}

count_lines() {
  read -p "Enter file path: " file
  if [ -f "$file" ]; then
    lines=$(wc -l "$file")
    echo -e "Lines in $file: \n\n$lines"
  else
    echo "File does not exist."
  fi
}

display_first_n_lines() {
  read -p "Enter file path: " file
  read -p "Enter number of lines to display: " n
  if [ -f "$file" ]; then
    head -n "$n" "$file"
  else
    echo "File does not exist."
  fi
}

display_last_n_lines() {
  read -p "Enter file path: " file
  read -p "Enter number of lines to display: " n
  if [ -f "$file" ]; then
    tail -n "$n" "$file"
  else
    echo "File does not exist."
  fi
}

while true; do
  clear_screen
  echo "1. Search for a file"
  echo "2. Search for a word in a file"
  echo "3. Search for a file and a word inside it"
  echo "4. Count number of lines in a file"
  echo "5. Display first n lines of a file"
  echo "6. Display last n lines of a file"
  echo -e "0. Exit \n"
  read -p "Enter your choice: " choice

  case "$choice" in
    1) search_file;;
    2) search_word_in_file;;
    3) search_file_and_word;;
    4) count_lines;;
    5) display_first_n_lines;;
    6) display_last_n_lines;;
    0) break;;
    *) echo "Invalid choice";;
  esac

  read -n 1 -r -p "Press any key to continue..."
done

echo "Exiting..."

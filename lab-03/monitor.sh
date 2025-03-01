#!/bin/sh

while true; do
    clear
    echo "=================================="
    echo "     Tomella Process Manager      "
    echo "=================================="
    echo "1. Display running processes"
    echo "2. Search for a process"
    echo "3. Kill a process"
    echo "4. Restart a process"
    echo "5. Exit"
    echo "=================================="
    read -p "Choose an option: " option

    case $option in
        1)
            echo "PID   | CPU% | MEM% | COMMAND"
            echo "------------------------------"
            ps -eo pid,%cpu,%mem,cmd --sort=-%cpu
            read -p "Press Enter to continue..."
            ;;
        2)
            read -p "Enter the process name to search: " pname
            echo "Searching for '$pname'..."
            ps aux | grep -i "$pname"
            read -p "Press Enter to continue..."
            ;;
        3)
            read -p "Enter the PID of the process to kill: " pid
            if kill -9 $pid 2>/dev/null; then
                echo "Process $pid has been terminated."
            else
                echo "Failed to kill process $pid. Make sure it exists and you have permissions."
            fi
            read -p "Press Enter to continue..."
            ;;
        4)
            read -p "Enter the PID of the process to restart: " pid
            process_cmd=$(ps -o cmd= -p $pid)
            if [ -n "$process_cmd" ]; then
                kill -9 $pid
                echo "Restarting process: $process_cmd"
                nohup $process_cmd &>/dev/null &
                echo "Process restarted successfully."
            else
                echo "Process not found!"
            fi
            read -p "Press Enter to continue..."
            ;;
        5)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Try again."
            read -p "Press Enter to continue..."
            ;;
    esac
done

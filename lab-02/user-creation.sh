#!/bin/sh

clear_screen() {
    clear
}

newuser() {
    username=$1
    group=$2
    full_name=$3
    home_dir=$4
    shell=$5
    perm_home=$6
    perm_group=$7
    perm_other=$8

    if ! getent group "$group" > /dev/null 2>&1; then
        echo "Creating group: $group"
        groupadd "$group"
    fi

    if [ ! -d "/home/$home_dir" ]; then
        echo "Home directory /home/$home_dir does not exist. Creating it now."
        mkdir -p "/home/$home_dir"
    fi

    echo "Creating user: $username"
    useradd -m -d "/home/$home_dir" -s "$shell" -c "$full_name" -g "$group" "$username"
    
    echo "Setting permissions for home directory /home/$home_dir"
    chmod "$perm_home" "/home/$home_dir"
    
    echo "User $username created successfully."
}

newgroup() {
    groupname=$1
    gid=$2

    echo "Creating group: $groupname with GID: $gid"
    groupadd -g "$gid" "$groupname"
    echo "Group $groupname created successfully."
}

# Example usage
# newuser alice developers "Alice Developer" /home/alice /bin/bash 700 770 755
# newgroup developers 1001

clear_screen

echo "Select an option:"
echo "1. Create a new user"
echo "2. Create a new group"
read -p "Enter option [1 or 2]: " option

case $option in
    1)
        read -p "Enter username: " username
        read -p "Enter group: " group
        read -p "Enter full name: " full_name
        read -p "Enter home directory: " home_dir
        read -p "Enter shell: " shell
        read -p "Enter home directory permissions (e.g., 700): " perm_home
        read -p "Enter group permissions (e.g., 770): " perm_group
        read -p "Enter other permissions (e.g., 755): " perm_other
        newuser "$username" "$group" "$full_name" "$home_dir" "$shell" "$perm_home" "$perm_group" "$perm_other"
        ;;
    2)
        read -p "Enter group name: " groupname
        read -p "Enter GID: " gid
        newgroup "$groupname" "$gid"
        ;;
    *)
        echo "Invalid option selected."
        ;;
esac
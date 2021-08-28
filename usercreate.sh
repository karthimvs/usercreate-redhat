#!/bin/bash

##############################################################################
#Ver = 1.0
#Description = Create new Users and passwords for batch creation
#Author = KarthiMvs
##############################################################################

if [ $(id -u) -eq 0 ]; then
        read -p "Enter username : " username
        read -s -p "Enter password : " password
        read -p "Enter full name : " fullname
        egrep "^$username" /etc/passwd >/dev/null
        if [ $? -eq 0 ]; then
                echo "$username exists!"
                exit 1
        else
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                useradd -c "$fullname" -s /bin/bash -m -p "$pass" "$username"
                [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
        fi
else
        echo "Only root may add a user to the system."
        exit 2
fi

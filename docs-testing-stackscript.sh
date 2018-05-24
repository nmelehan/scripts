#!/bin/bash

# Sets up two users: nmelehan and linode_user
# Gives them passwordless sudo
# Adds my public key to them
# Also adds my public key to root user 
# and disables password authentication for SSH

full_name="Nathan M."
room_number=""
work_phone="855.454.6633 ext. 1324"
home_phone="305.322.5381"
public_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDh1IEZAjiorC2QkajXKgwG1iEf0P4LdhWaCOWvUOT0/vN08sYNqeTlo6OMR1+MKc9ods63iLpJ+26FafKZoifPFvWTdRi/E60qwSdamnbyAalvFJMbgI5pSkqo/1Z+P6CShHCe/q3ZaF7UYMIEbbVfgHIgoP3BL8AF8mswLekrqzUUGxymhhWScgp2AMS4Ocadl5boQBLcU/aWAdS6dnzEPMo2tnxNLkHXpvPACECUfzAd0JzR1IhWVocluYvyzrRN1wp4eb5UDDyQC7Te33b+8aDnvnUV78WkoAeBHrzAFQk+kvJ4k6RM51bAdhSCZbvJTeC/1K0yzSuXzroJbzwqNfvnhh8rRdIQoyRyuQ5qb5c9qDNHzaLUUrQ7BWrj7EXfRmr50PNAgB/J1Bt5nD/kqnEUZ+tXnwcKaLGYUzEuDuwJV1jRTbhV58DgiITdY3hGw96KERhsqokgcxRE2R5OkVp8X/ctQ+cc1LnaRFbGY8vLCOfw211lslGJQAsDtg+yCdYW/N0vA79TrYI80uBIZ+kdYhXqzzSCMCZ+tlma42hULAFHk6GWUAbm+UeL4lXo5Mzm3vJtiHablZU5Jpy8NmzXHz1dOqjC1FweMteCsbJ169SQx+sJl0BMCjMm+6kuMpGxs3Rk8/Dp2KDvnC+nH7TVv0ENfxX7VBcmKgYOrw== nathan-personal@nmelehans-MacBook-Pro.local"

function set_up_user() {
        echo "Setting up user: $1"
        adduser $1 --disabled-password --gecos "$full_name,$room_number,$work_phone,$home_phone"
        adduser $1 sudo
        echo "$1 ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers.d/passwordless_sudoers
        mkdir /home/$1/.ssh
        echo "$public_key" | tee /home/$1/.ssh/authorized_keys
}

set_up_user "nmelehan"
set_up_user "linode_user"

mkdir /root/.ssh
echo "$public_key" | tee /root/.ssh/authorized_keys
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart ssh
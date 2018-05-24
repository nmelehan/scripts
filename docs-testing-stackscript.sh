#!/bin/bash

full_name="Nathan M."
room_number=""
work_phone="855.454.6633 ext. 1324"
home_phone="305.322.5381"
public_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDh1IEZAjiorC2QkajXKgwG1iEf0P4LdhWaCOWvUOT0/vN08sYNqeTlo6OMR1+MKc9ods$

function set_up_user() {
        echo "Setting up user: $1"
        adduser $1 --disabled-password --gecos "$full_name,$room_number,$work_phone,$home_phone"
        adduser $1 sudo
        echo "$1 ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/passwordless_sudoers
        mkdir /home/$1/.ssh
        echo $public_key | tee /home/$1/.ssh/authorized_keys
}

mkdir /root/.ssh
echo $public_key | tee /root/.ssh/authorized_keys
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

set_up_user "nmelehan"
set_up_user "linode_user"
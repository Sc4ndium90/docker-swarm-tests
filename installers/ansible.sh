#!/bin/bash

# This script installs Ansible for Debian 12. 
# As the repository of Ansible for Debian is deprecated, we have to use Ubuntu repository with Ubuntu PPA

if (whoami != root)
  then echo "Please run as root"
  exit
fi

echo "Installing required dependencies (wget & gpg)"
apt update && apt upgrade -y && apt install wget gpg

echo "Installing Ansible for Debian.."

UBUNTU_CODENAME=jammy
wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | tee /etc/apt/sources.list.d/ansible.list
apt update && apt install ansible -y

echo "Installation of Ansible is done"

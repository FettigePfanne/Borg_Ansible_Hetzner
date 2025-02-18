#!/bin/bash

# Update Paketliste und Upgrade der installierten Pakete
echo "Updating package list and upgrading installed packages..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Installation von Ansible und sshpass
echo "Installing Ansible and sshpass..."
sudo apt install -y ansible sshpass
sudo apt install cifs-utils

echo "Installation complete."
echo "______________________________________________________________________"

nano config_vars.yml
nano password.yml
ansible-vault encrypt password.yml
nano inventory.ini

echo "Bearbeitung abgeschlossen. Skript fährt fort..."

# Ausführen des Ansible-Playbooks
echo "Running Ansible playbook..."
ansible-playbook -i inventory.ini playbook.yaml --ask-become --ask-vault-pass

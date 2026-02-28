#!/bin/bash
# Filename: linux-nginx.sh
# Task: Create a Linux VM and install Nginx server

# Create a resource group
az group create --name MyAppResourceGroup --location westeurope

# Create the VM 
az vm create --resource-group MyAppResourceGroup --name MyLinuxVM --image Debian --admin-username azureuser --generate-ssh-key

# Alternatively you may create the VM using your key
# az vm create --resource-group MyAppResourceGroup --name MyLinuxVM --image Debian --admin-username azureuser --ssh-key-value ~/.ssh/id_rsa.pub

# Install Nginx server
az vm run-command invoke --resource-group MyAppResourceGroup --name MyLinuxVM --command-id RunShellScript --scripts "sudo apt-get update && sudo apt-get install -y nginx"

# Openup port 80
az vm open-port --port 80 --resource-group MyAppResourceGroup --name MyLinuxVM
# Use the Public IP address for the VM to view the installed server with a browser

# ssh into the VM
ssh azureuser@13.95.156.193 

# delete the resource group and all its related resources when you are done
# az group delete --name MyAppResourceGroup

# https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-cli
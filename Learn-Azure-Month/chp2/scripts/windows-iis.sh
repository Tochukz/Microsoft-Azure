#!/bin/bash
# Filename: linux-nginx.sh
# Task: Create a Windows VM and install IIS server 

# Create a resource group
az group create --name MyWebResourceGroup --location westeurope

# Create the VM
az vm create --resource-group MyWebResourceGroup --name MyWindowsVM --image Win2022AzureEditionCore --public-ip-sku Standard --admin-username azureuser

# Install IIS server
az vm run-command invoke --resource-group MyWebResourceGroup --name MyWindowsVM --command-id RunPowerShellScript --scripts "Install-WindowsFeature -name Web-Server -IncludeManagementTools"

# Open port 89
az vm open-port --port 80 --resource-group MyWebResourceGroup --name MyWindowsVM

# delete the resource group and all its related resources when you are done
# az group delete --name MyWebResourceGroup

# Your can Remote into you Windows VM using Remote Desktop Connection and your username and password

# https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-cli

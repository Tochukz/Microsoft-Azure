# Description: This script allows you to obtain you Azure storage account access key
# You need to set your ResourceGroupName and StorageAccountName or export them to the terminal before runing the script.

resourceGroupName=SimpleTableRG
storageAccountName=simpletable18350

key=$(az storage account keys list --resource-group $resourceGroupName --account-name $storageAccountName --query "[0].value" --output tsv)

echo "AZURE_ACCESS_KEY=$key"

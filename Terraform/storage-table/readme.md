# Simple Table

### Description
The configuration creates an Azure storage table.

### To deploy
```
$ terraform apply
```

### After deployment
After deployment the the resource group Id and storage account id are part of the output.  
The resource group name and storage account name can be seen as the last segment of the resource group Id and storage account id output respectively.

### Get storage account access key
To get your storage account key
```
$  az storage account keys list --resource-group SimpleTableRG --account-name simpletable18350
```

Copy the `value` property value from the first object in the result array.
Alternatively, you can run the `account-key.sh` script to get the storage account access key.

To view the storage account details

```
$ az storage account show --resource-group SimpleTableRG --name simpletable18350
```

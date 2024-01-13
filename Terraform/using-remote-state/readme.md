# Remote State
### Description
This configuration shows how to use Azure storage container to store Terraform state.  

### Setup
First, you need to create a storage container where the terraform state will leave.  
But you also need to create the storage account where the container will leave and also the resource group to house the storage account.   
You may run the _create-storage_ bash script to do this.
```
$ ./create-storage.sh
```

### Learn more
[Store Terraform state in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)   

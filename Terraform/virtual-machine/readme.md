# Simple Server 
### Description 
The configuration provisions a Linux virtual machine in a virtual network.  

### Deployment 
First create a terraform plan 
```
$ terraform plan -out main.tfplan 
```
Next, apply the plan 
```
$ terraform apply main.tfplan
```

### Verify deployment 
After deployment is complete you can check the deployed VM using Azure CLI. 
First, set the azure resource group to a variable 
```
$ resource_group_name=$(terraform output -raw resource_group_name)
```
List all the VMs in the resource group 
```
$ az vm list --resource-group $resource_group_name 
```
You can use a _JMESPath query_ to display the names of the virtual 
```
$ az vm list --resource-group $resource_group_name --query "[].{\"VM Name\":name}" -o table
```

### Clean up 
After testing, you may want to delete all the provisioned resources.  
First create a destroy plan
```
$ terraform plan -destroy -out main.destroy.tfplan
```
Next, apply the destroy plan 
```
$ terraform apply main.destroy.tfplan
```
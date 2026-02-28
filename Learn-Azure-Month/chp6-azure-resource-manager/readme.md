### Chapter 6: Azure Resource Manager
Resource Manager is an approach to how to build and deploy resources, as much as the automation processes and templates that drive those deployments.

#### The Azure Resource Manager approach
__Designing around the application lifecycle__   
There are a couple of main approaches for grouping resources in Azure:
1. All resources for a given application in the same resource group
2. Like-minded resources grouped by function in the same resource group

__Securing and controlling resources__  
In Azure, there are four core roles you can assign to resources, much like file permissions:
1. __Owner__: Complete control. Basically, an administrator.
2. __Contributor__: Able to fully manage the resource, except making changes to the
security and role assignments.
3. __Reader__: Can view all information about the resource, but make no changes.
4. __User access administrator__: Able to assign or remove access to resources.  

As you explore the available roles, you may notice several resource-specific roles.  
These include the following:
1. Virtual Machine Contributor
2. Website Contributor
3. Network Contributor
They take the core platform Contributor role and apply it to a specific resource type.  

__Protecting resources with locks__   
Another feature built in to the Resource Manager model is resource locks. Each resource can have a lock applied that limits it to read-only access or prevents delete operations.  
For production workloads, I suggest you implement locks on your core resources to prevent deletes.  

__Managing and grouping resources with tags__   
You can apply tags to a resource in Azure that describes properties such as the application it’s part of, the department responsible for it, or whether it’s a development or production resource.  
You can then target resources based on tags to apply locks or RBAC roles, or report
on resource costs and consumption.  

#### Azure Resource Manager templates
__Creating multiples of a resource type__  
There are more than 50 types of functions in Resource Manager, just like in most programming and scripting languages. Common Resource Manager functions include length, equals, or, and trim. You control the number of instances to create with the copy function.   

__Tools to build your own templates__  
One of the best ways to learn how to create and use templates is to examine the quickstart templates Microsoft makes available in its samples repo at https://github.com/Azure/azure-quickstart-templates.  
You can also install the _Azure Resource Manager_ VSCode extension.  
A more graphical way to build Azure Resource Manager templates is to use the full
_Visual Studio_ editor.  

__Lab: Deploying Azure resources from a template__    
[Template: Simple Linux VM](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.compute/vm-simple-linux)  


### ARM Deployment
__Deploy a ARM template using Azure CLI__    
To deploy an ARM template, first create a resource group
```
$ az group create --name simple-linux --location westeurope
```
Next, deploy the ARM template to the resource group  
```
$ az deployment group create --resource-group simple-linux --template-file simple-linux.json --parameters @simple-linux.parameters.json
```

__View deployment outputs__  
After deployment, you can view the output as follows:  
First get the deployment name
```
$ az deployment group list --resource-group simple-linux --output table  
```  
Next, copy the deployment name from the previous command and  get the outputs
```
$ az deployment group show --name <deployment-name> --resource-group simple-linux --query "properties.outputs"
```  

__Clean up__  
To delete the resource group
```
$ az group delete --name simple-linux
```

#### Learn more
[Azure ARM Quickstart Template](https://github.com/Azure/azure-quickstart-templates)  

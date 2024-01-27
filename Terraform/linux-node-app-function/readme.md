# Azure Functions
### Description
This configuration creates the resources needed to support Azure function project.  
Check out the example azure project at [Simple Azure Func](../../Azure-Docs/Azure-Functions/simple-api)

### Deployment
__Deploy the configuration__
```
$ terraform apply
```  

__Deploy Azure function code__  
First you must have _azure-functions-core-tools_ and _azure/functions_ installed on your local machine.
Then you can deploy you azure project to Azure using the followinf command.  
```
$ cd simple-api
$ func azure functionapp publish func70036
```  
Learm more from [Azure-Function](../../Azure-Docs/Azure-Functions).  

### Learn more
[Deploying Azure Functions with Terraform](https://medium.com/@abhimanyubajaj98/deploying-azure-functions-with-terraform-and-visual-studio-code-d7bd6d629aa5)

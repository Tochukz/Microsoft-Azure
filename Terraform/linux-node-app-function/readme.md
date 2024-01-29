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
Alternatively, you can deploy a function app project using Azure CLI `az functionapp` command:
```
$
```

### Operation
__Invoke an azure function remotely__  
The function in question should be a HTTP Triggered function
1. Get the App keys
```
$ az functionapp keys list --resource-group <resource-group-name> --name <function-app-name>
```
Copy the value of the _masterKey_ from the output.
2. Use the masterKey from step one for HTTP header
The masterKey from step one is used as the value of _x-functions-key_ in a _curl_ request
```
$ curl  http://func39261.azurewebsites.net/api/sample-func -i -d '{}' -H 'x-functions-key: xxxxxxxxxx' -H 'content-type: application/json'  -L
```

Learn more from [Azure-Function](../../Azure-Docs/Azure-Functions).  

### Learn more
[Deploying Azure Functions with Terraform](https://medium.com/@abhimanyubajaj98/deploying-azure-functions-with-terraform-and-visual-studio-code-d7bd6d629aa5)

## Azure Functions
[MS Docs](https://learn.microsoft.com/en-us/azure/azure-functions/functions-overview?pivots=programming-language-javascript)   

### Azure Functions overview
#### Scenarios
The following are a common (but by no means exhaustive) set of scenarios for Azure Functions.

If you want...           | Then...
-------------------------|----------  
Process file upload      | Run code when a file is uploaded or changed in blob storage.
Run scheduled task       | Execute data clean-up code on pre-defined timed intervals.
Build a scalable web API | Implement a set of REST endpoints for your web applications using HTTP triggers.

#### Development lifecycle
Functions integrates directly with _Visual Studio_, _Visual Studio Code_, _Maven_, and other popular development tools to enable seamless debugging and deployments.   
Functions also integrates with _Azure Monitor_ and _Azure Application Insights_ to provide comprehensive runtime telemetry and analysis of your functions in the cloud.

[Deployment technologies in Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/functions-deployment-technologies?tabs=windows)  
[Monitor executions in Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/functions-monitoring)

__Create a JavaScript function in Azure from the command line__  
1. Install the Core Tools package:
```bash
$ brew tap azure/functions
$ brew install azure-functions-core-tools@4
# if upgrading on a machine that has 2.x or 3.x installed:
# brew link --overwrite azure-functions-core-tools@4
$ func --version
```
2. Create a local function project
```bash
$ mkdir simple-api
$ cd simple-api
$ func init --javascript
```  
3.  Add a function to your project
```bash
$ func new --name HttpExample --template "HTTP trigger" --authlevel "anonymous"
```  
The _--name_ argument is the unique name of your function and the _--template_ argument specifies the function's trigger.  
4. Add Azure Storage connection information in local.settings.json.
```json
{
    "Values": {       
        "AzureWebJobsStorage": "<Azure Storage connection string>",
        "FUNCTIONS_WORKER_RUNTIME": "node"
    }
}
```
The connection string typically looks like this: `DefaultEndpointsProtocol=https;AccountName=<yourStorageAccountName>;AccountKey=<yourAccountKey>;EndpointSuffix=core.windows.net`

5. Run the function locally
```bash
$ func start
```

__Create supporting Azure resources for your function__   
Before you can deploy your function code to Azure, you need to create three resources:
1. A _resource group_, which is a logical container for related resources.
2. A _storage account_, which is used to maintain state and other information about your functions.  
3. A _function app_, which provides the environment for executing your function code.

You can create there resources using the Azure CLI, Azure Portal or IaC tool such as _ARM_, _Bicept_ or Terraform.   

__Deploy the function project to Azure__  
```
$ func azure functionapp publish <APP_NAME>
```  

[Create a JavaScript function in Azure from the command line](https://learn.microsoft.com/en-us/azure/azure-functions/create-first-function-cli-node)


#### Hosting options
Functions provides a variety hosting options for your business needs and application workload.
1. Fully serverless, pay for execution time (Consumption plan),
2. Always warm instance, ready for fastest response times (Premium plan).
3. Existing App Service plan
4. Deploy your functions in containers

### Tooling
### Azure Functions scenarios
[Azure Functions scenarios](https://learn.microsoft.com/en-us/azure/azure-functions/functions-scenarios?pivots=programming-language-javascript)    

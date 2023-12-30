## Simple Node App    
__Deploy the configuration__  
```
$ terraform apply 
```

__Confirm the deployed Webapp__  
```
$ az webapp show --resource-group SimpleRG97104 --name SimpleWebApp97104
``` 

__Package node application__     
Package the application using zip
```
$ cd simple-express
$ zip -r simple-express.zip . -x ".git/*"
```  
_simple-express_ is a newly installed ExpressJS application. 
Note that the packaging includes all the content of the application directory while excluding the parent directory itself and the `.git` directory.  

__Deploy web app to Azure__      
To deploy the WebApp to Azure using Azure CLI, use the syntax: 
```
$ az webapp deployment source config-zip --resource-group <resource-group-name> --name <web-app-name> --src app.zip
``` 
Replace the parameters for _resource group name_ and  _web app name_ with actual values obtained from you terraform deployment output.  
```
$ az webapp deployment source config-zip --resource-group SimpleRG97104 --name SimpleWebApp97104 --src simple-express.zip 
```  

__Checkout other az webapp commands__ 
```
$ az webapp --help 
``` 

__Commonly userd az webapp commands__  
SSH into the WebApp 
```
$ az webapp ssh --resource-group SimpleRG97104 --name SimpleWebApp97104
```
Restart the webapp
```
$ az webapp restart --resource-group SimpleRG97104 --name SimpleWebApp97104
```

__Using AI search__ 
To search AI knowledge base for examples, use: az find "az webapp deploy"
```
$ az find "az webapp deploy"
```  

__Learn More__      
[App servic provision resource terraform](https://learn.microsoft.com/en-us/azure/app-service/provision-resource-terraform)   
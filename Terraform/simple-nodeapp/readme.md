## Simple Node App    
__Package node application__     
Package the application using zip
```
$ zip -r simple-express.zip simple-express -x simple-express/node_modules/\*
```

__Deploy web app to Azure__      
To deploy the WebApp to Azure using Azure CLI 
```
$ az webapp deployment source config-zip --resource-group <your-resource-group> --name <your-web-app-name> --src app.zip
``` 
Replace the parameters using values for _resource group name_ and  _web app name_     
```
$ az webapp deployment source config-zip --resource-group SimpleRG97104 --name SimpleWebApp97104 --src simple-express.zip 
```  

__Learn More__      
[App servic provision resource terraform](https://learn.microsoft.com/en-us/azure/app-service/provision-resource-terraform)   
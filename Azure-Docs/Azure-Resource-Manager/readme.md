## Azure Resource Manager  
[ARM Docs](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview)  
[ARM Template Docs](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/overview)  
[Bicep Docs](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep)  
[ARM Quickstart Template](https://github.com/Azure/azure-quickstart-templates)   

__Introduction__  
You use management features, like _access control_, _locks_, and _tags_, to secure and organize your resources after deployment.  

### Terminology
1. __Resource__:  A manageable item that is available through Azure.
2. __Resource group__: A container that holds related resources for an Azure solution.
3. __Resource provider__: A service that supplies Azure resources. For example _Microsoft.Compute_, _Microsoft.Storage_ etc.
4. __Declarative syntax__: Syntax that lets you state "Here's what I intend to create" without having to write the sequence of programming commands to create it.
5. __ARM Template__: A JavaScript Object Notation (JSON) file that defines one or more resources to deploy to a resource group, subscription, management group, or tenant.
6. __Bicep file__: A file for declaratively deploying Azure resources.   

### Understand scope
Azure provides four levels of scope:  
1. Management groups
2. Subscriptions
3. Resource groups
4. Resources

### Resource groups
There are some important factors to consider when defining your resource group:
1. All the resources in your resource group should share the same lifecycle.
2. You can move a resource from one resource group to another group.
3. The resources in a resource group can be located in different regions than the resource group.  
4.  When selecting a resource group location, we recommend that you select a location close to where your control operations originate. Typically, this location is the one closest to your current location.

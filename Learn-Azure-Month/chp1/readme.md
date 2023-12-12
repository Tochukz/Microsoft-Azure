### Chapter 1: Before you begin

__Installing Azure CLI__  
For MacOS, install using _homebrew_  
```
$ brew update
$ brew install azure-cli
$ az version
```
For other OS see [how to install the Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

A new release is available roughly every three weeks.  
To upgrade  
```
$ az upgrade
```
Learn more at [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/)

__Sign-in for the Azure CLI__  
```
$ az login
```
This will open-up your default browser where you can login. Return back to the terminal window after login.  

If the browser fails to open you can run
```
$ az login --use-device-code.
```

__Finding commands__  
To search for all commands containing the word _"secret"_  
```
$ az find secret
```  
To get all the command in `nsg` (Network Security Group) subgroup in the `network` group of commands:  
```
$ az network nsg --help
```

__Multiple Accounts__  
If you have login in to Azure using more that one account on the same machine, you can set the account you want to be active.  
First, list the accounts you have login with i.e your subscriptions.  
```
$ az account list
```  
Copy the _id_ of the subscription to make  your current active subscription.  
Set it as you active subscription.   
```
$ az account set --subscription "35akss-subscription-id"
```   
To see your active subscription
```
$ az account show
```

__VSCode Plugin__  
Install the _Azure CLI Tools_ VSCode extension.   
The plugin offers an interactive experience, including autocomplete and mouse-over documentation.

__Understanding the Azure Platform__    
Most of what you create in Azure falls into the IaaS and PaaS areas. The main use cases include VMs and virtual networking (IaaS), or the Azure Web Apps, Functions, and Cosmos DB (PaaS) services.

__Virtualization in Azure__   
Virtualization logically divides physical resources in a server into virtual resources that can be securely accessed by individual workloads. A VM is one of the most common resources in cloud computing. A VM contains a virtual CPU (vCPU), memory (vRAM), storage (vDisk), and network connectivity (vNIC).    
[Explore Azure global infrastructure](https://azure.microsoft.com/en-us/explore/global-infrastructure/)  

__Azure Service Principal__  
An Azure _service principal_ is an identity created for use with applications, hosted services, and automated tools to access Azure resources. This access is restricted by the roles assigned to the service principal, giving you control over which resources can be accessed and at which level.  

__Create a Service Principal__   
First, copy you subscription ID
```
$ az account show
```
Next, create the service principal with a role
```
$ az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"
```
Remember to replace the `<SUBSCRIPTION_ID>` with the subscription ID copied from the result of the previous command.  
Finally, you should set environment variables using the values returned from the previous command.  
```
$ export ARM_CLIENT_ID="<APPID_VALUE>"
$ export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"
$ export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
$ export ARM_TENANT_ID="<TENANT_VALUE>"
```

__Management__  
There are various management tools available to manage your resources  
* [Azure Portal](http://portal.azure.com)  
* [Azure PowerShell](https://learn.microsoft.com/en-us/powershell/azure/get-started-azureps)  
* [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
* [Azure Cloud Shell](http://shell.azure.com)

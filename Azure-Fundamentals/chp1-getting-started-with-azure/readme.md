## Chapter 1: Getting started with Microsoft Azure  

__Overview of Cloud computing__  
A hybrid cloud integrates public and private clouds, allowing you to host workloads in the most appropriate location. For example, you could host a high-scale website in the public cloud and link it to a highly secure database hosted in your private cloud (or on-premises datacenter).   

Microsoft provides support for public, private, and hybrid clouds.  
_Microsoft Azure Stack_ is an add-on to Windows Server 2016 that allows you to deploy many core Azure services in your own datacenter and provides a self-service portal experience to your users. You can integrate these into a hybrid cloud through the use of a virtual private network.

__Billing__  
To help organize all of the resources in a subscription for billing purposes, you can assign tags to each resource and then retrieve all of the billing information for a specific tag.
For example, if one department owns a web application and several related components, you can assign the same tag to all of those resources. Then, you can retrieve the billing for that department by retrieving the billing for that tag.

__Resource Group__   
A resource group is a logical container to hold related resources for an application or group of applications. These tips should be considered when making decisions about your resource group:
* A resource can only be assigned to one group at a time.
* All of the resources in a group should have the same lifecycle.
* The resources in a resource group can be in different regions.
* You can use a resource group to control access for the resources therein.

__Resource Manager__  
You can export the current state of the resources in a resource group to a template. This can then be used as a pattern for other deployments, or it can be edited and redeployed to make changes and additions to the current resource group’s resources.  

__Role based access control__  
With Resource Manager, you can grant permissions at a specified scope: subscription, resource group, or resource. This means you can deploy a set of resources into a resource group and then grant permissions to one or more specific users, groups, or service principal.  

__Roles__  
Each role has a list of Actions and Not Actions. The Actions are allowed, and the Not Actions are excluded.  

__Custom Roles__   
Custom roles are stored in the Azure AD and can be shared across all subscriptions that use the same Active Directory.  
A convenient way to create a custom role is to download the definition of an existing role and use that as a starting point. When you create a custom role, you also need to specify in which subscriptions it can be used—at least one must be specified.  

__Share administrative privileges for your Azure subscription__   
Once you have signed up for an Azure subscription, you can give administrative access to additional Microsoft accounts.  

__Azure Price Calculator__  
[Price Calculator](https://azure.microsoft.com/en-us/pricing/calculator/)  

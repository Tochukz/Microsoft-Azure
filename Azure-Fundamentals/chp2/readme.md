## Chapter 2: Azure App Service and Web Apps
__Azure App Service__  
The App Service is a service that hosts one of five kinds of applications:
1. Web Apps
2. Logic Apps
3. Mobile Apps
4. API Apps
5. Function Apps
Each app runs in its own app service.

__App Service plan__  
An App Service plan defines the capacity and resources to be shared among one or more app services that are assigned to that plan.     
Using App Service plans enables you to run multiple applications on one set of VMs, even if each of the applications is deployed separately.    
When you create your App Service plan, the resources you requested are allocated for you. When you deploy an app to that App Service plan, it simply deploys the applications to those allocated resources.     

__Web App__  
A Web App is a web application that is hosted in an App Service. Supported languages include .NET, Java, PHP, Node.js, and Python.  
You can use continuous deployment with Team Foundation Server (TFS), GitHub, TeamCity, Jenkins, or BitBucket so that every time you commit a change, a new version of the web app is deployed.  

__Web App scaling__   
Scaling is done by scaling the App Service plan to which the web app belongs. You can scale the number of instances in and out on demand. You can configure autoscaling so Azure will scale it in or out for you depending on specific performance measures such as CPU percentage. You can also publish your website to multiple locations and use the Azure Traffic Manager to handle the routing of the traffic to the location nearest to your customer.  

__Web App diagnostics__  
For diagnostics, you can gather performance statistics, application logging, web server logging, IIS logs, and IIS Failed Request logs. If you’re using Microsoft Visual Studio, you can even remotely debug your application while it is running in the cloud.  

__Creating Web Apps__  
There are multiple options for creating a Web App and deploying the content to an app service.
1. Azure Marketplace
2. Visual Studio Code
3. Visual Studio

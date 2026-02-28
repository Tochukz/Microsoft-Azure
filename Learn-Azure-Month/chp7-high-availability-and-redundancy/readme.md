### Chapter 7: High availability and redundancy  
You can use Azure high availability and redundancy features to minimize disruptions caused by maintenance updates and outages.   

__The need for redundancy__  
To give you flexibility and control over how to make your application highly available, two main features for IaaS workloads are available:
1. __Availability Set__ — Lets you logically group VMs to distribute them across a single Azure datacenter and minimize disruption from outages or maintenance
updates.
2. __Availability Zone__ — Lets you distribute VMs across physically isolated segments of an Azure region to further maximize your application redundancy. Zones can also provide high availability to network resources such as public IP addresses and load balancers.

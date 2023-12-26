### Chapter 5: Azure Network Basics  
__Virtual network components__   
The main components that you use for VMs are as follows:
* Virtual networks and subnets (including IP address pools)
* Virtual network interface cards
* One or more public IP addresses
* Internal DNS name and optional public DNS names for external name resolution
* Network security groups and rules, which secure and control the flow of network
traffic like a regular firewall does

__IP address assignment types__  
A _dynamic assignment_ allocates a public IP address when the VM is started. When the VM is stopped, the public IP address is deallocated.
1. You won’t have a public IP address until you assign it to a VM and start it.
2. The public IP address may change if you stop, deallocate, and start the VM.  

A _static assignment_ means you have a public IP address allocated without an associated VM, and that address won’t change:
1. This is useful for scenarios where you’re using an SSL certificate mapped to an IP address, or a custom DNS name and record that points to the IP address.
2. Right now, you’re using a single VM. For production use, you’ll ideally run your application on multiple VMs with a load balancer in front of them. In that scenario, the public IP address is assigned to the load balancer and typically creates a static assignment at that point.  

__Creating a network security group__   
The Azure host doesn’t differentiate between traffic from the internet and traffic from elsewhere within your Azure environment, such as another subnet or virtual network. Any inbound network packet has the inbound NSG rules applied, and any outbound network packet has the outbound NSG rules applied.

The flexibility of NSGs means you can associate multiple subnets, across various virtual networks, with a single NSG. It’s a one-to-many mapping, which allows you to define core network security rules that apply to a wide range of resources and applications.   

__Creating remote access network connections__   
In production, you shouldn’t open remote access, such as SSH or RDP, to VMs that run your applications. You typically have a separate jump-box VM that you connect to from the internet, and then you access additional VMs over the internal connection.  

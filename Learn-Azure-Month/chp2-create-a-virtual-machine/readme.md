### Chapter 2: Create a virtual machine
[Virtual Machine Docs](https://learn.microsoft.com/en-us/azure/virtual-machines/)  

__Azure Storage__  
Type of storage available:  
1. _Premium SSD disks_: Uses low-latency, high-performance SSDs. Perfect for production workloads for best performance.
2. _Standard SSD disks_: Uses standard SSDs. Delivers consistent performance compared to HDDs. Great for development and testing workloads, or budget-conscious and low-demand production use.  
3. _Standard HDD disks_: Uses regular spinning disks. Ideal for infrequent data access such as archive data or backups. Not recommended for running application workloads.  

__VM Sizes__  
The family types are as follows:
1. _General purpose_: Great for development and testing, or low-use production databases or web servers.
2. _Compute optimized_: High-performance CPUs, such as for production application servers.
3. _Memory optimized_: Larger memory options, such as when you need to run big databases or tasks that require a lot of in-memory data processing.
4. _Storage optimized_: Low-latency, high-disk performance for disk-intensive applica- tions.
5. _GPU_: Nvidia-based graphics-specialized VMs, if you need graphics rendering or video processing.
6. _High-performance computing (HPC)_ Lots of everything! Plenty of CPU, memory, and network throughput for the most demanding of workloads.

#### Common Operation
##### Create a Linux virtual machine with the Azure CLI
1. Create a resource group
```
$ az group create --name MyAppResourceGroup --location westeurope
```
2. Create the VM
```
$ az vm create --resource-group MyAppResourceGroup --name MyLinuxVM --image Debian --admin-username azureuser --generate-ssh-key
```
To create the VM using your key, use the `--ssh-key-value` flag instead of `--generate-ssh-key`
```
$ az vm create --resource-group MyAppResourceGroup --name MyLinuxVM --image Debian --admin-username azureuser --ssh-key-value ~/.ssh/id_rsa.pub
```
3. Install a Nginx web server
```
$ az vm run-command invoke --resource-group MyAppResourceGroup --name MyLinuxVM --command-id RunShellScript --scripts "sudo apt-get update && sudo apt-get install -y nginx"
```
4. Open port 80 for web traffic
```
$ az vm open-port --port 80 --resource-group MyAppResourceGroup --name MyLinuxVM
```  
5. Use the Public IP address for the VM to view the installed server in a browser
6. SSH into the VM
```
$ ssh azureuser@13.95.156.193
```
7. Cleanup up your resources by removing the resource group and all its related resources  
```
$ az group delete --name MyAppResourceGroup
```

__To SSH into the VM from the different machine__  
1. Download the SSH private key from the VM
```
$ az vm run-command invoke --name MyLinuxVM --resource-group MyAppResourceGroup --command-id RunShellScript --scripts "cat /etc/ssh/ssh_host_ecdsa_key" --query "value[0].message" > MyLinuxKey2.pem
```
2. Edit the _MyLinuxKey2.pem_ key file leaving only content start from `-----BEGIN OPENSSH PRIVATE KEY-----` upto `-----END OPENSSH PRIVATE KEY-----`. Also replace every new line characters `\n` with actual new lines.   

Todo: This downloaded key does not work at the moment. Find out why.

##### Create a Windows virtual machine with the Azure CLI
1. Create resource group
```
$ az group create --name MyWebResourceGroup --location westeurope  
```
2. Create the VM
```
$ az vm create --resource-group MyWebResourceGroup --name MyWindowsVM --image Win2022AzureEditionCore --public-ip-sku Standard --admin-username azureuser
```
You will be prompted to enter a password. Alternatively, your could use the `--admin-password` parameter to specify a password.  
3. Install IIS WebServer
```
$ az vm run-command invoke --resource-group MyWebResourceGroup --name MyWindowsVM --command-id RunPowerShellScript --scripts "Install-WindowsFeature -name Web-Server -IncludeManagementTools"
```
4. Open port 80
```
$ az vm open-port --port 80 --resource-group MyWebResourceGroup --name MyWindowsVM
```  
5. Use the Public IP address for the VM to view the installed server in a browser
6. Remote into the VM using _Remote Desktop Connection_ and your username and password.   
7. Cleanup up your resources by removing the resource group and all its related resources  
```
$ az group delete --name MyWebResourceGroup
```

__Azure Resource Group__  
A resource group is a container that holds related resources for an Azure solution. The resource group can include all the resources for the solution, or only those resources that you want to manage as a group.  

__Learn More__  
[Create a Linux virtual machine with the Azure CLI](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-cli)  
[Create a Windows virtual machine with the Azure CLI](https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-cli)  
[Connect to a VM using Remote Desktop Protocol on a Mac](https://learn.microsoft.com/en-us/azure/lab-services/connect-virtual-machine-mac-remote-desktop)   
[Azure Region Names](https://azuretracks.com/2021/04/current-azure-region-names-reference/)  

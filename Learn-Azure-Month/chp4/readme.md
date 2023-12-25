### Chapter 4: Introduction to Azure Storage
__Azure storage account__  
Azure storage account have four types of storage as described below:   
1. _Blob_: for unstructured data such as media files and documents. Applications can store data in blob storage, such as images, and then render them.  
2. _Table_: for unstructured data in a NoSQL data store
3. _Queue_: for cloud applications to communicate between various tiers and components in a reliable and consistent manner. You can create, read, and delete messages that pass between application components.
4. _File Storage_: for a good old-fashioned Server Message Block (SMB) file share, accessible by both Windows and Linux/macOS platforms


__Table Storage__  
The touted advantages of NoSQL databases are that they scale horizontally (meaning you can add more servers rather than adding more memory or CPU), can handle larger amounts of data, and are more efficient at processing those large data sets.
How the data is stored in a NoSQL database can be defined in a few categories:
* Key-value, such as _Redis_
* Column, such as _Cassandra_
* Document, such as _MongoDB_  
Each approach has pros and cons from a performance, flexibility, or complexity viewpoint.  
You can download and install the Microsoft Azure Storage Explorer from [storageexplorer.com](www.storageexplorer.com) if you like to visualize the data.  
An Azure storage table uses a _key-value store_ and is a good introduction to NoSQL databases.

__Queue Storage__  
Queues allow you to create, read, and then delete messages that carry small chunks of data. These messages are created and retrieved by different application components as they pass data back and forth. Azure Queues won’t delete a message until an application component confirms it has finished acting on it when read.  


__Authenticate to Azure__   
Application requests to most Azure services must be authorized. Using the _DefaultAzureCredential_ class provided by the _Azure Identity client_ library is the recommended approach for implementing passwordless connections to Azure services in your code.  
_DefaultAzureCredential_ offers improved management and security benefits over the _account key_ to allow passwordless authentication.  

__Authorization for Queue__   
You'll need _Storage Queue Data Contributor_ to read and write queue data. To assign yourself this role, you'll need to be assigned the _User Access Administrator_ role, or another role that includes the _Microsoft.Authorization/roleAssignments/write_ action. You can assign Azure RBAC roles to a user using the Azure portal, Azure CLI, or Azure PowerShell.

To assign a role at the resource level using the Azure CLI, you first must retrieve the resource id using the `az storage account show` command.
```
$ az storage account show --resource-group '<your-resource-group-name>' --name '<your-storage-account-name>' --query id
```  
 You can then assign roles using the `az role` command of the Azure CLI.
 ```
$ az role assignment create --assignee "<user@domain>" --role "Storage Queue Data Contributor" --scope "<your-resource-id>"
 ```

__Object model__  
Azure Queue Storage is a service for storing large numbers of messages. Queues are commonly used to create a backlog of work to process asynchronously.
Queue Storage offers three types of resources:
* __Storage account__: All access to Azure Storage is done through a storage account.   
* __Queue__: A queue contains a set of messages. All messages must be in a queue.
* __Message__: A message, in any format, of up to 64 KB. A message can remain in the queue for a maximum of 7 days.   


#### Get storage account access key
To get your storage account key
```
$  az storage account keys list --resource-group <your-resource-group-name> --account-name <your-storage-account-name>
```  
Copy the `value` property value from the first object in the result array.

To view the storage account details

```
$ az storage account show --resource-group <your-resource-group-name> --name <your-storage-account-name>  
```

#### Queue Operations
To add message to a queue, the message must be serializable.
Assuming you want to add a JSON message to a queue you must encode the message into a base64 string and you must decode the message after retrival.  

__To encode a JSON string to Base64__  

```
$ base64Str=$(echo '{"description": "Meaty Pizza", "cost": 120 }' | base64)
$ echo $base64Str
```

__To decode a Base64 string__  
```
$  jsonStr=$(echo 'eyJkZXNjcmlwdGlvbiI6Ik1lYXR5IFBpenphIiwiY29zdCI6MTIwfQ==' | base64 --decode)
$ echo jsonStr  
```

__To push a message to a queue__  
```
$ az storage message put --account-name simplequeues8te189w --queue-name simple-queue --content $(echo '{"description": "Meaty Pizza", "cost": 120 }' | base64)
```
If you have your storage account access key, you can include the  `--account-key` parameter to you command. This is especially useful if you have not authenticated your local azure cli for storage queue service.  

__To retrieve a message at the front of the queue__   
```
$ az storage message peek --account-name simplequeues8te189w --queue-name simple-queue
```  

#### Tools
[Azure Storage Explorer](https://azure.microsoft.com/en-us/products/storage/storage-explorer/)  

#### Learn more
[Azure CLI Storage](https://learn.microsoft.com/en-us/cli/azure/storage/message?view=azure-cli-latest)  

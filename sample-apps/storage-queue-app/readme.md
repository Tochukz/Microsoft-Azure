# Simple Queue API

### Description

This application interacts with Azure Storage Queue service.

**Object model**  
Use the following JavaScript classes to interact with these resources:

- **QueueServiceClient**: A QueueServiceClient instance represents a connection to a given storage account in the Azure Storage Queue service. This client allows you to manage the all queues in your storage account.
- **QueueClient**: A QueueClient instance represents a single queue in a storage account. This client allows you to manage and manipulate an individual queue and its messages.

**Note**  
Messages sent using the QueueClient class must be in a format that can be included in an XML request with UTF-8 encoding.
To include markup in a queue message, the contents of the message must either be XML-escaped or Base64-encoded.


### Learn more
[Storage QuickStart](https://learn.microsoft.com/en-us/azure/storage/queues/storage-quickstart-queues-nodejs?tabs=passwordless%2Croles-azure-portal%2Cenvironment-variable-windows%2Csign-in-azure-cli)   

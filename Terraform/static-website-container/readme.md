# Static Website Container

### Description
This configuration deploys an Azure storage account which is configured to server as a static website.  
The Azure storage account has a special Blob container name _$web_ where all the static files live.  

### Deployment
```
$ terraform apply
```

### After deployment
List the existing assets
```
$ az storage blob list --account-name staticstoreqtgugxbk --container-name \$web --output table
```

Copy react app to the _$web_ storage container.  
```
$ az storage blob upload-batch --account-name staticstoreqtgugxbk --source sample-react/build  --destination \$web --overwrite
```

### Learn more
[Static website](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-static-website-terraform?tabs=azure-cli)

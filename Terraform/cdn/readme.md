# Content Delivery Network

### Description
This configuration deploys a content delivery endpoint with an origin host that points to a static website.  
You can update the configuration by adding an Azure static website and replace the origin hostname with the static website primary web host.

### Deployment
To deploy the configuration
```
$ terraform apply
```

After deployment, you must wait at least an hour until the content is being populated, during that time the CDN return 404.

### Caching
To clear the cdn endpoint cache, you run the _endpoint purge_ operation.  
```
$ az cdn endpoint purge --resource-group sampleGroup --profile-name sampleProfile --name sampleCdnEndpoint --no-wait --content-path "/*"
```

### Learn more

[Create an Azure CDN profile and endpoint using Terraform](https://learn.microsoft.com/en-us/azure/cdn/create-profile-endpoint-terraform?tabs=azure-cli)  
[Purge an Azure CDN endpoint](https://learn.microsoft.com/en-us/azure/cdn/cdn-purge-endpoint)

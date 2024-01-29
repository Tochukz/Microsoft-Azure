
# Set these variables using output values from the terraform deployment
resourceGroupName=funcs-rg-39261
functionAppName=func39261

# Set variable to the function as written in the function code
functionName=sample-func
az functionapp function invoke --resource-group $resourceGroupName --name $functionAppName  --function-name $functionName --data "{}"
az functionapp restart --resource-group $resourceGroupName --name $functionAppName
#!/bin/bash
# Filename: deploy-func.sh
# Description: Builds and deploys Node.js function app code to Azure Function with Node.js runtime

# Set these variables using output values from the terraform deployment
resourceGroupName=funcs-rg-39261
functionAppName=func39261

cd ../../sample-apps/sample-func 
npm install --omit=dev
rm app.zip
zip -r app.zip . -x ".git/*"
az functionapp deployment source config-zip --resource-group $resourceGroupName --name $functionAppName --src app.zip
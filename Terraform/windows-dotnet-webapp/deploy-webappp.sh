#!/bin/bash
# Filename: deploy-webapp.sh
# Description: Builds and deploys Dotnet Core web application code to Azure Windows Web App Service

# Set these variables using output values from the terraform deployment
resourceGroupName=simplerg45307
webAppName=windowsapp45307

cd ../../sample-apps/SampleApp
dotnet publish -c Release
cd bin/Release/net7.0/publish
zip -r publish.zip .  

start_time=$SECONDS

az webapp deployment source config-zip --resource-group $resourceGroupName --name $webAppName --src publish.zip
az webapp restart --resource-group $resourceGroupName --name $webAppName

elapsed_time=$((SECONDS - start_time))
minutes=$((elapsed_time / 60))
echo "Deploy time in seconds: $elapsed_time seconds"
echo "Deploy time in minutes: $minutes minutes"

#!/bin/bash
# Filename: deploy-webapp.sh
# Description: Builds and deploys Node.js web application code to Azure Linux Web App Service

# Set these variables using output values from the terraform deployment
resourceGroupName=SimpleRG69605
webAppName=SimpleWebApp69605

appType=$1
if test -z "$appType"
then
  echo "Please specify the app type e.g ./deploy-webapp.sh express"
  exit
fi

case $appType in
  express)
    cd ../../sample-apps/express-app
    zip -r app.zip . -x ".git/*"
    ;;
  nest)
    cd ../../sample-apps/nest-app
    npm run build
    cp package.json dist/
    cp -r node_modules dist/
    cd dist
    zip -r app.zip . -x ".git/*"
    ;;
  dotnet)
    echo -n "Not yet implemented deployment app type: $appType"
    exit
    ;;
  *)
    echo -n "Unsupported app type: $appType"
    exit
    ;;
esac

#start_time=$(date +%s.%N)
start_time=$SECONDS

az webapp deployment source config-zip --resource-group $resourceGroupName --name $webAppName --src app.zip


elapsed_time=$((SECONDS - start_time))
minutes=$((elapsed_time / 60))
echo "Deploy time in seconds: $elapsed_time seconds"
echo "Deploy time in minutes: $minutes minutes"

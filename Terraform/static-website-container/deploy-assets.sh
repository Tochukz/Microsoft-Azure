#!/bin/bash
# Filename: deploy-assets.sh
# Description: Builds and deploys React application code to Azure Azure storage container to server as a static website.

storageAccountName=staticstorefdvwxbuz

cd ../../sample-apps/react-app
npm install
npm run build

az storage blob upload-batch --account-name $storageAccountName --source build  --destination \$web --overwrite
az storage blob list --account-name $storageAccountName --container-name \$web --output table

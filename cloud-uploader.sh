#!/bin/bash

#Get the file to be uploaded from the user
file_path=$1

#Check if the user gave some input
if [ -z "$file_path" ]; then
   echo "Missing Argument"
   echo "Usage: $0 <file_path>"
   exit 1
fi

#Check if the file path provided exists or not
if [ ! -f "$file_path" ]; then
   echo "Error: File '$file_path' not found."
   exit 1
fi

#Check if the Azure CLI is installed so the user can continue
if ! command -v az &> /dev/null; then
   echo "Azure CLI is not installed. Please install it and try again"
   exit 1
else 
   echo -n "Enter your storage account name: "
   read storage_account
   echo -n "Enter your storage account key: "
   read storage_account_key
   echo -n "Enter your storage account container name: "
   read container_name
fi

#Login with Azure CLI to authenticate
az login

#Finally, upload the file to Azure Blob Storage
az storage blob upload \
  --account-name $storage_account \
  --account-key $storage_account_key \
  --container-name $container_name \
  --file $file_path

#Check if your file was successfully uploaded
if [ $? -eq 0 ]; then
   echo "File successfully uploaded to Azure Blob Storage"
else 
   echo "Error: File failed to upload to Azure Blob Storage"
fi

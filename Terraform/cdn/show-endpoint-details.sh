resource_group_name=$(terraform output -raw resource_group_name)
cdn_profile_name=$(terraform output -raw cdn_profile_name)
endpoint_name=$(terraform output -raw endpoint_name)

az cdn endpoint show --resource-group $resource_group_name --profile-name $cdn_profile_name --name $endpoint_name
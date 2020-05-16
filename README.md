# Azure Resource Manager Quickstart Templates

This repository contains sample Azure Resource Manager templates for various FileMage Gateway deployment scenarios. These templates are meant to be used a reference implementation and should be customized for each users individual requirements.


### Sample Usage

```
cd 201-high-availability-managed-database

az group create --name FileMageGateway --location "West US"

az deployment group create \
    --name filemagesample \
    --resource-group FileMageGateway \
    --template-file azuredeploy.json \
    --parameters azuredeploy.parameters.json
```

[ARM template documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/)

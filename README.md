# Azure Resource Manager Quickstart Templates

This repository contains sample Azure Resource Manager templates for various FileMage Gateway deployment scenarios. These templates are meant to be used a reference implementation and should be customized for each users individual requirements.

It is highly recommended that template parameters containing sensitive data such as passwords and encryption strings be loaded from [Azure Key Vault](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/key-vault-parameter) for production deployments.

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

[Use Azure Key Vault to pass secure parameter value during deployment
](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/key-vault-parameter)

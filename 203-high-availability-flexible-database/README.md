# Deploy Load Balanced FileMage Gateway With Managed PostgreSQL

This template provides a easy way to deploy a load balanced deployment of FileMage Gateway with a Azure managed database for PostgreSQL.

The template will create a virtual network and subnet. If you want to deploy into a existing virtual network, remove that resource from the template and replace the variable `subnetId` with the ID of your existing subnet.

The parameter `adminAccessIp` specifies your local workstation or office IP address. This is used to create a firewall rule to the managed database for administrative purposes.

The parameter `adminCidr` specifies the CIDR address range of your local workstation or office. This is used to restrict SSH access.

Once the deployment is complete use the DNS name from the output `loadbalancerDns` to access your deployment.

## Post Deployment

After deploying the template, it is recommended to restart the database to apply the extension settings. This can be done in the Azure Portal or using the following commands:

```
DB_NAME=$(az deployment group show --resource-group YourResourceGroupName -n YourDeploymentName --query properties.outputs.dbName.value -otsv)
az postgres flexible-server restart --resource-group YourResourceGroupName --name $DB_NAME
```

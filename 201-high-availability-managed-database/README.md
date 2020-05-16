# Deploy Load Balanced FileMage Gateway With Managed PostgreSQL

This template provides a easy way to deploy a load balanced deployment of FileMage Gateway with a Azure managed database for PostgreSQL.

The template will create a virtual network and subnet. If you want to deploy into a existing virtual network, remove that resource from the template and replace the variable `subnetId` with the ID of your existing subnet.

The parameter `adminAccessIp` specifies your local workstation or office IP address. This is used to create a firewall rule to the managed database for administrative purposes.

The parameter `adminCidr` specifies the CIDR address range of your local workstation or office. This is used to restrict SSH access.

Once the deployment is complete use the DNS name from the output `loadbalancerDns` to access your deployment.

[<img src="http://azuredeploy.net/deploybutton.png"/>](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ffilemage%2Fazure-quickstart-templates%2Fmaster%2F201-high-availability-managed-database%2Fazuredeploy.json)

# Deploy Load Balanced FileMage Gateway With Virtual Machine PostgreSQL

This template provides a easy way to deploy a load balanced deployment of FileMage Gateway and Azure database for PostgreSQL.

The template will create a virtual network and subnet. If you want to deploy into a existing virtual network, remove that resource from the template and replace the variable `subnetId` with the ID and `subnetAddress` with the address prefix of your existing subnet.

The parameter `adminCidr` specifies the CIDR address range of your local workstation or office. This is used to restrict SSH and non-subnet database access.

Once the deployment is complete use the IP address from the output `loadbalancerPublicIp` to access your deployment.

[<img src="http://azuredeploy.net/deploybutton.png"/>](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ffilemage%2Fazure-quickstart-templates%2Fmaster%2F202-high-availability-vm-database%2Fazuredeploy.json)

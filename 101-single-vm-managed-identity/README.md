# Deploy Single VM FileMage Gateway and Storage Account with Managed System Identity Access

This template shows how to use managed system identities to give FileMage Gateway access to storage accounts without having to use access keys.

The template will create a virtual network and subnet. If you want to deploy into a existing virtual network, remove that resource from the template and replace the variable `subnetId` with the ID and `subnetAddress` with the address prefix of your existing subnet.

The parameter `adminCidr` specifies the CIDR address range of your local workstation or office. This is used to restrict SSH access.

Once the deployment is complete use the DNS name from the output `appFqdn` to access your deployment.

[<img src="http://azuredeploy.net/deploybutton.png"/>](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ffilemage%2Fazure-quickstart-templates%2Fmaster%2F101-single-vm-managed-identity%2Fazuredeploy.json)

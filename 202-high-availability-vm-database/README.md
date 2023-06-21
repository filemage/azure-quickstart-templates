# Deploy Load Balanced FileMage Gateway With Virtual Machine PostgreSQL

This template provides a easy way to deploy a load balanced deployment of FileMage Gateway with a virtual machine with PostgreSQL installed and configured.

The template will create a virtual network and subnet. If you want to deploy into a existing virtual network, remove that resource from the template and replace the variable `subnetId` with the ID and `subnetAddress` with the address prefix of your existing subnet.

The parameter `adminCidr` specifies the CIDR address range of your local workstation or office. This is used to restrict SSH and non-subnet database access.

Once the deployment is complete use the DNS name from the output `loadbalancerDns` to access your deployment.

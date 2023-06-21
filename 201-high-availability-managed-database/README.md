# Deploy Load Balanced FileMage Gateway With Managed PostgreSQL

This template provides a easy way to deploy a load balanced deployment of FileMage Gateway with a Azure managed database for PostgreSQL.

The template will create a virtual network and subnet. If you want to deploy into a existing virtual network, remove that resource from the template and replace the variable `subnetId` with the ID of your existing subnet.

The parameter `adminAccessIp` specifies your local workstation or office IP address. This is used to create a firewall rule to the managed database for administrative purposes.

The parameter `adminCidr` specifies the CIDR address range of your local workstation or office. This is used to restrict SSH access.

Once the deployment is complete use the DNS name from the output `loadbalancerDns` to access your deployment.

Note: If you modify the template to use an existing subnet for the application instances, you must add a service endpoint for `Microsoft.Sql` to enable access to the managed database service.

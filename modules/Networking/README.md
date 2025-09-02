# Networking Module

Creates Azure virtual networking infrastructure including VNets, subnets, and security groups.

## Purpose
- Establishes network foundation for Azure resources
- Implements network segmentation and security
- Configures private networking and connectivity

## Resources Created
- `azurerm_virtual_network` - Virtual networks
- `azurerm_subnet` - Network subnets
- `azurerm_network_security_group` - Security groups
- `azurerm_subnet_network_security_group_association` - NSG associations
- `azurerm_private_dns_zone` - Private DNS zones

## Usage
```hcl
module "networking" {
  source = "../modules/Networking"
  
  Virtual_Network        = var.Virtual_Network
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping
  region_mapping         = var.region_mapping
  service_type          = var.service_type_mapping["Virtual_Network"]
  environment_name      = var.environment_mapping[var.env_name]
}
```

## Features
- Multi-subnet architecture
- Network security rules
- Private DNS integration
- Service endpoints
- Network peering support

# Azure Infrastructure Terraform Configuration

This repository contains Terraform configurations for deploying Azure infrastructure across multiple environments (test, prod) using a modular approach.

## Project Structure

```
Terraform_updated/
├── modules/                    # Reusable Terraform modules
│   ├── Resource_Group/         # Azure resource groups
│   ├── Key_Vault/             # Azure Key Vault
│   ├── Networking/            # VNets, subnets, NSGs
│   ├── Storage_Accounts/      # Azure Storage
│   ├── App_Service/           # Web applications
│   ├── Function_app/          # Serverless functions
│   ├── SQL_Server/            # Database services
│   ├── Api_Management_Console/ # API gateway
│   ├── Logic_Apps/            # Workflow automation
│   ├── Service_Bus/           # Message queuing
│   ├── Application_Insights/  # Application monitoring
│   ├── Log_Analytics_Workspace/ # Centralized logging
│   └── ... (other modules)
├── test/                      # Test environment
│   ├── main.tf               # Main configuration
│   ├── variables.tf          # Variable definitions
│   ├── test.auto.tfvars      # Environment mappings
│   └── terraform.tfvars      # Resource configurations
└── prod/                      # Production environment
    ├── main.tf               # Main configuration
    ├── variables.tf          # Variable definitions
    ├── prod.auto.tfvars      # Environment mappings
    └── terraform.tfvars      # Resource configurations
```

## How It Works

### 1. Modular Architecture
- **Modules**: Reusable components in `/modules/` directory
- **Environments**: Separate configurations for test and prod
- **Standardization**: Consistent naming and tagging across resources

### 2. Configuration Flow
```
Environment Config (test/prod) → Calls Modules → Creates Azure Resources
```

### 3. Naming Convention
Resources follow the pattern: `{region}-{environment}-{service}-{type}`

**Examples:**
- `w1-tst-<app-name>-app` (Test App Service in West US)
- `w1-prd-<app-name>-sql` (Production SQL Server in West US)

### 4. Environment Mappings
| Environment | Code | Region | Code |
|-------------|------|--------|------|
| dev | dev | westus | w1 |
| test | tst | westus2 | w2 |
| prod | prd | eastus | eu1 |
| staging | stg | eastus2 | eu2 |

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Azure subscription with appropriate permissions

## Setup Instructions

### 1. Azure Authentication

```bash
# Login to Azure
az login

# Set your subscription
az account set --subscription "<your-azure-subscription-id>"
```

### 2. Configure Variables

**Replace placeholder values in:**
- `test/test.auto.tfvars` - Update subscription_id
- `prod/prod.auto.tfvars` - Update subscription_id
- `test/terraform.tfvars` - Update resource configurations
- `prod/terraform.tfvars` - Update resource configurations

**Key placeholders to replace:**
- `<your-azure-subscription-id>`
- `<app-name>`
- `<company-name>`
- `<database-password>`
- `<redis-password>`
- `<service-bus-key>`

## Deployment Workflow

### Test Environment
```bash
cd Terraform_updated/test/

# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Plan deployment
terraform plan

# Apply changes
terraform apply
```

### Production Environment
```bash
cd Terraform_updated/prod/

# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Plan deployment
terraform plan

# Apply changes (use caution)
terraform apply
```

## Module Usage

Each module can be called from environment configurations:

```hcl
module "resource_group" {
  source = "../modules/Resource_Group"
  
  Resource_Group     = var.Resource_Group
  region_mapping     = var.region_mapping
  service_type       = var.service_type_mapping["Resource_Group"]
  environment_name   = var.environment_mapping[var.env_name]
}
```

## Key Features

### 🏗️ **Infrastructure Components**
- **Compute**: App Services, Function Apps, Logic Apps
- **Storage**: Storage Accounts, SQL Databases
- **Networking**: VNets, Subnets, NSGs, Private Endpoints
- **Security**: Key Vault, Managed Identities
- **Monitoring**: Application Insights, Log Analytics
- **Integration**: API Management, Service Bus

### 🔧 **Configuration Management**
- Environment-specific variable files
- Consistent naming conventions
- Resource tagging strategy
- Dependency management

### 🛡️ **Security Features**
- Azure Key Vault integration
- Managed Identity authentication
- Network security groups
- Private endpoints
- Secure connection strings

## Best Practices

### Development Workflow
1. **Test First**: Always test changes in test environment
2. **Plan Review**: Review `terraform plan` output before applying
3. **Incremental Changes**: Make small, incremental updates
4. **Documentation**: Update documentation with changes

### Security Guidelines
- Store secrets in Azure Key Vault
- Use managed identities where possible
- Implement least privilege access
- Enable monitoring and alerting
- Regular security reviews

### Resource Management
- Use consistent tagging
- Implement proper naming conventions
- Monitor resource costs
- Clean up unused resources
- Use resource locks for critical resources

## Troubleshooting

### Common Issues

1. **Authentication errors**
   ```bash
   az account show  # Verify current subscription
   az login         # Re-authenticate if needed
   ```

2. **Permission errors**
   - Verify account has Contributor/Owner permissions
   - Check resource provider registrations

3. **Resource conflicts**
   - Check for existing resources with same names
   - Review resource group contents

4. **State file issues**
   ```bash
   terraform refresh  # Sync state with actual resources
   terraform import   # Import existing resources
   ```

### Useful Commands

```bash
# Format Terraform files
terraform fmt -recursive

# Validate configuration
terraform validate

# Show current state
terraform show

# List resources in state
terraform state list

# Plan with detailed output
terraform plan -detailed-exitcode
```

## Contributing

1. Create feature branches for changes
2. Test changes in test environment first
3. Use descriptive commit messages
4. Update documentation as needed
5. Follow established naming conventions

## Support

For questions or issues:
1. Check the troubleshooting section
2. Review module-specific README files
3. Create an issue in this repository

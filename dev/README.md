# Development Environment Configuration

This directory contains the **improved** Terraform configuration for the development environment with enhanced features and best practices.

## 🚀 New Features & Improvements

### ✅ **Enhanced Configuration**
- **Remote State Backend** - Azure Storage backend configuration
- **Variable Validation** - Input validation for critical variables
- **Comprehensive Outputs** - Better module integration and debugging
- **Pre-commit Hooks** - Automated code quality checks
- **Makefile Automation** - Simplified command execution

### ✅ **Better Organization**
- **Modular Variables** - Cleaner variable definitions with validation
- **Example Configuration** - `terraform.tfvars.example` template
- **Structured Outputs** - Clear output definitions for all modules
- **Documentation** - Enhanced README with usage examples

## 📁 File Structure

```
dev/
├── main.tf                    # Main configuration with backend
├── variables.tf               # Enhanced variables with validation
├── outputs.tf                 # Comprehensive outputs
├── dev.auto.tfvars           # Environment-specific values
├── terraform.tfvars.example   # Configuration template
├── .pre-commit-config.yaml   # Code quality hooks
├── Makefile                  # Automation commands
└── README.md                 # This documentation
```

## 🛠️ Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Pre-commit](https://pre-commit.com/) (optional, for code quality)
- Azure subscription with appropriate permissions

## 🚀 Quick Start

### 1. Setup Backend Storage (First Time Only)

```bash
# Create storage account for Terraform state
az group create --name "terraform-state-rg" --location "westus"
az storage account create --name "terraformstatedev" --resource-group "terraform-state-rg" --location "westus" --sku "Standard_LRS"
az storage container create --name "tfstate" --account-name "terraformstatedev"
```

### 2. Configure Variables

```bash
# Copy example configuration
cp terraform.tfvars.example terraform.tfvars

# Edit with your actual values
nano terraform.tfvars
```

### 3. Deploy Infrastructure

```bash
# Using Makefile (recommended)
make deploy

# Or manually
terraform init
terraform plan
terraform apply
```

## 🔧 Configuration

### Backend Configuration

Update `main.tf` with your backend storage details:

```hcl
backend "azurerm" {
  resource_group_name  = "terraform-state-rg"
  storage_account_name = "terraformstatedev"
  container_name       = "tfstate"
  key                  = "dev.terraform.tfstate"
}
```

### Variable Validation

Variables now include validation rules:

```hcl
variable "env_name" {
  validation {
    condition     = contains(["dev", "test", "prod"], var.env_name)
    error_message = "Environment must be dev, test, or prod."
  }
}
```

## 📊 Available Commands

### Using Makefile

```bash
make help      # Show available commands
make init      # Initialize Terraform
make test      # Run validation and formatting
make plan      # Create execution plan
make apply     # Apply changes
make destroy   # Destroy infrastructure
make clean     # Clean temporary files
```

### Manual Commands

```bash
# Initialize and setup
terraform init

# Validate configuration
terraform validate

# Format code
terraform fmt -recursive

# Plan deployment
terraform plan -out=tfplan

# Apply changes
terraform apply tfplan

# Show outputs
terraform output
```

## 🔍 Validation Features

### Input Validation
- **Environment names** - Must be valid environment types
- **Subscription ID** - Must be valid GUID format
- **Resource mappings** - Cannot be empty
- **Resource groups** - At least one must be defined

### Pre-commit Hooks
```bash
# Install pre-commit hooks
pre-commit install

# Run hooks manually
pre-commit run --all-files
```

## 📈 Outputs

The configuration provides comprehensive outputs:

```bash
# View all outputs
terraform output

# Specific outputs
terraform output resource_group_names
terraform output storage_account_names
terraform output app_service_urls
```

## 🛡️ Security Best Practices

### State File Security
- Remote backend with encryption
- Access control via Azure RBAC
- State locking to prevent conflicts

### Variable Management
- Sensitive variables marked appropriately
- Validation rules prevent invalid inputs
- Example files exclude sensitive data

### Resource Security
- Managed identities for authentication
- Network security groups and private endpoints
- Key Vault integration for secrets

## 🧪 Testing

### Automated Testing
```bash
# Run all tests
make test

# Individual tests
terraform validate
terraform fmt -check
terraform plan -detailed-exitcode
```

### Manual Testing
1. Deploy to dev environment
2. Verify resource creation
3. Test application functionality
4. Check monitoring and logging

## 🔄 CI/CD Integration

### GitHub Actions Example
```yaml
- name: Terraform Init
  run: terraform init

- name: Terraform Validate
  run: terraform validate

- name: Terraform Plan
  run: terraform plan
```

### Azure DevOps Example
```yaml
- task: TerraformInstaller@0
- task: TerraformTaskV2@2
  inputs:
    command: 'init'
- task: TerraformTaskV2@2
  inputs:
    command: 'validate'
```

## 📝 Development Workflow

1. **Create Feature Branch**
   ```bash
   git checkout -b feature/new-resource
   ```

2. **Make Changes**
   - Update Terraform configuration
   - Add/modify variables as needed
   - Update documentation

3. **Test Changes**
   ```bash
   make test
   terraform plan
   ```

4. **Deploy to Dev**
   ```bash
   make apply
   ```

5. **Verify and Commit**
   ```bash
   git add .
   git commit -m "Add new resource configuration"
   git push origin feature/new-resource
   ```

## 🆘 Troubleshooting

### Common Issues

1. **Backend Access Issues**
   ```bash
   az login
   az account set --subscription "<subscription-id>"
   ```

2. **State Lock Issues**
   ```bash
   terraform force-unlock <lock-id>
   ```

3. **Validation Errors**
   ```bash
   terraform validate
   terraform fmt
   ```

### Getting Help

- Check the main project README
- Review module-specific documentation
- Use `terraform plan` to preview changes
- Check Azure portal for resource status

## 🔗 Related Documentation

- [Main Project README](../README.md)
- [Module Documentation](../modules/README.md)
- [Production Environment](../prod/README.md)
- [Test Environment](../test/README.md)

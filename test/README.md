# Test Environment Configuration

This directory contains Terraform configuration for the **test environment** with enhanced features and best practices.

## 🚀 Enhanced Features

### ✅ **Improvements Added**
- **Remote State Backend** - Azure Storage backend configuration
- **Variable Validation** - Input validation for critical variables
- **Comprehensive Outputs** - Better module integration and debugging
- **Pre-commit Hooks** - Automated code quality checks
- **Makefile Automation** - Simplified command execution

## Files Overview

| File | Purpose |
|------|---------|
| `main.tf` | Main configuration with backend and module calls |
| `variables.tf` | Enhanced variable definitions with validation |
| `outputs.tf` | Comprehensive outputs for integration |
| `test.auto.tfvars` | Environment-specific variable values (auto-loaded) |
| `terraform.tfvars` | Additional configuration variables |
| `terraform.tfvars.example` | Configuration template |
| `.pre-commit-config.yaml` | Code quality automation |
| `Makefile` | Automation commands |

## 🛠️ Quick Start

### Using Makefile (Recommended)
```bash
# Deploy everything
make deploy

# Individual commands
make init      # Initialize Terraform
make test      # Run validation and formatting
make plan      # Create execution plan
make apply     # Apply changes
make destroy   # Destroy infrastructure
```

### Manual Commands
```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Plan deployment
terraform plan

# Apply changes
terraform apply
```

## 🔧 Configuration

### Backend Setup
Update `main.tf` with your backend storage details:
```hcl
backend "azurerm" {
  resource_group_name  = "terraform-state-rg"
  storage_account_name = "terraformstatetest"
  container_name       = "tfstate"
  key                  = "test.terraform.tfstate"
}
```

### Variable Configuration
Copy and customize the example file:
```bash
cp terraform.tfvars.example terraform.tfvars
# Edit with your actual values
```

## Environment Naming

- Environment: `test` → `tst`
- Resources follow pattern: `{region}-{env}-{service}-{type}`
- Example: `w1-tst-<app-name>-app`

## 🔍 Validation Features

Variables include validation rules:
- Environment names must be valid
- Subscription ID must be GUID format
- Resource mappings cannot be empty
- At least one resource group required

## 📊 Outputs Available

```bash
terraform output resource_group_names
terraform output storage_account_names
terraform output app_service_urls
terraform output virtual_network_ids
```

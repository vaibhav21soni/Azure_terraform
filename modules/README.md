# Terraform Modules

This directory contains reusable Terraform modules for Azure infrastructure components.

## Available Modules

| Module | Description |
|--------|-------------|
| **Action_Group** | Azure Monitor action groups for alerting |
| **Api_Management_Console** | Azure API Management service |
| **App_Service** | Azure App Service web applications |
| **App_Service_Plan** | Azure App Service hosting plans |
| **Application_Insights** | Application monitoring and analytics |
| **Function_app** | Azure Functions serverless compute |
| **Key_Vault** | Azure Key Vault for secrets management |
| **Log_Analytics_Workspace** | Centralized logging workspace |
| **Logic_Apps** | Workflow automation service |
| **Managed_Identities** | Azure managed identities |
| **Networking** | Virtual networks, subnets, and NSGs |
| **Resource_Group** | Azure resource group containers |
| **Service_Bus** | Message queuing service |
| **SQL_Replica_Server** | SQL Server replica configuration |
| **SQL_Server** | Azure SQL Server and databases |
| **Storage_Accounts** | Azure Storage accounts |

## Module Structure

Each module contains:
- `*.tf` - Main resource definitions
- `variables.tf` - Input variables
- `outputs.tf` - Output values (if applicable)

## Usage

```hcl
module "example" {
  source = "../modules/ModuleName"
  
  # Required variables
  variable_name = value
}
```

## Best Practices

- Use consistent naming conventions
- Define clear input/output variables
- Include resource tags for management
- Follow Azure naming standards

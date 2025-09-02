

This repository has been sanitized to remove all sensitive and personally identifiable information before sharing on GitHub. The following types of data have been replaced with placeholders:


| Type | Original | Placeholder |
|------|----------|-------------|
| Azure Subscription ID | Real subscription ID | `<your-azure-subscription-id>` |
| Database Passwords | Real passwords | `<database-password>` |
| Redis Cache Passwords | Real passwords | `<redis-password>` |
| Service Bus Access Keys | Real keys | `<service-bus-key>` |
| Company Name | Actual company name | `<company-name>` |
| Database Usernames | Real usernames | `<database-user>` |
| Email Addresses | Personal/company emails | `<name>@<company-domain>` |
| Personal Names | Real names | `<name>` |
| Application Names | Real app names | `<app-name>` |
| Database Names | Real database names | `<database-name>` |
| Container Registry | Real registry URLs | `<container-registry>` |


- `test/test.auto.tfvars`
- `prod/prod.auto.tfvars`
- `test/terraform.tfvars`
- `prod/terraform.tfvars`


1. **Comprehensive .gitignore**: Prevents accidental commits of sensitive files
2. **Example files**: Template files showing expected structure without sensitive data
3. **Restore script**: Helper script to safely restore actual values for deployment
4. **Documentation**: Clear instructions on handling sensitive data


1. Use the `restore-values.sh` script to replace placeholders with actual values
2. Verify all configurations are correct
3. Ensure sensitive files are not tracked by Git
4. Consider using Azure Key Vault for production secrets


- Never commit files containing actual sensitive values
- Use environment-specific configurations
- Implement proper access controls
- Regularly rotate secrets and keys
- Use Azure Key Vault for production deployments


For questions about this sanitization process or security concerns, please create an issue in this repository.

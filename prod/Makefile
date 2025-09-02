.PHONY: help init plan apply destroy validate fmt clean test

# Default target
help:
	@echo "Available targets:"
	@echo "  init     - Initialize Terraform"
	@echo "  validate - Validate Terraform configuration"
	@echo "  fmt      - Format Terraform files"
	@echo "  plan     - Create Terraform execution plan"
	@echo "  apply    - Apply Terraform configuration"
	@echo "  destroy  - Destroy Terraform-managed infrastructure"
	@echo "  clean    - Clean Terraform files"
	@echo "  test     - Run validation and formatting checks"

# Initialize Terraform
init:
	terraform init

# Validate configuration
validate:
	terraform validate

# Format Terraform files
fmt:
	terraform fmt -recursive

# Create execution plan
plan:
	terraform plan -out=tfplan

# Apply configuration
apply:
	terraform apply tfplan

# Destroy infrastructure
destroy:
	terraform plan -destroy -out=tfdestroy
	terraform apply tfdestroy

# Clean up files
clean:
	rm -f tfplan tfdestroy
	rm -rf .terraform/
	rm -f .terraform.lock.hcl

# Run tests
test: fmt validate
	@echo "All tests passed!"

# Full deployment workflow
deploy: init test plan apply
	@echo "Deployment completed!"

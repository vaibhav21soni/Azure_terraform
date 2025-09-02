

1. **Never commit sensitive data**: Always use placeholder values for subscription IDs, secrets, and other confidential information
2. **Test your changes**: Always test in the test environment before applying to production
3. **Follow naming conventions**: Use the established naming patterns for resources


1. Create a feature branch from main
2. Make your changes in the appropriate environment folder (test/prod) or modules
3. Test your changes:
   ```bash
   cd test/
   terraform init
   terraform validate
   terraform plan
   ```
4. Format your code:
   ```bash
   terraform fmt -recursive
   ```
5. Create a pull request with a clear description


- [ ] No hardcoded subscription IDs
- [ ] No secrets or passwords in code
- [ ] All sensitive values use placeholders like `<your-value-here>`
- [ ] .gitignore includes all sensitive file patterns
- [ ] State files are not committed


- Use consistent indentation (2 spaces)
- Add comments for complex logic
- Use descriptive variable names
- Follow Terraform best practices
- Keep modules focused and reusable


Before submitting:
1. Run `terraform validate` on all configurations
2. Run `terraform plan` to check for issues
3. Verify no sensitive data is exposed
4. Test module changes in isolation

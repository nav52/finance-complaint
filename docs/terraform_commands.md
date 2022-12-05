# Terraform commands to setup the infrastructure

1. Install AWS CLI and configure
2. Install Google Cloud Shell and configure
3. Install Terraform

[NOTE] : Make sure all the above are added to your PATH

### Initialise Terraform
```
terraform init
```

### Validate Terraform files
```
terraform validate
```

### Check the planned configuration
```
terraform plan
```

### Apply the configuration
```
terraform apply --auto-approve
```

### Delete the applied infrastructure post use
```
terraform destroy --auto-approve
```
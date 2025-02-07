# AWS Terraform Lab

Terraform configuration to manage a free-tier EC2 instance on AWS.

# Prerequisites
- Install AWS CLI   (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Install Terraform (https://developer.hashicorp.com/terraform/install?product_intent=terraform)
- AWS account       (need  AWS Access key ID & Secret access key) Dont use root access (Best Practises)

## Features
- Creates a t2.micro instance
- Auto-generates SSH key pair
- Restricts SSH access to your current IP
- Cleanup with `terraform destroy`

## Usage
```bash
terraform init
terraform fmt
terraform apply
terraform destroy
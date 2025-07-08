AWS Documentation Referenced: 
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html 
aws-provider-config.tf 
provider "aws" {
region = "us-east-1"
}
resource "aws_iam_user" "demouser" {
name = "demo-user"
}

CLI Commands Used: 
terraform apply -auto-approve
terraform destroy -auto-approve

AWS CLI commands Used: 
aws configure

terraform destroy
terraform destroy -target aws_instance.myec2

GitHub Provider Terraform: 
https://registry.terraform.io/providers/integrations/github/latest/docs 
Code Used: 
terraform {
required_providers {
github = {
source = "integrations/github"
version = "~> 5.0"
}
}
}
provider "github" {
token = "your-token-here"
}
resource "github_repository" "example" {
name = "example"
description = "My codebase"
 visibility = "public"
}

Initialize and Apply: 
terraform init
terraform plan
terraform apply
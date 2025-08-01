terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.3.2"
    }
  }
}

provider "github" {
  token = "your-github-tocken"
}

resource "github_repository" "example" {
  name        = "terraform-repo"

  visibility  = "private"

}
```
#### Initialize and Apply:
```sh
terraform init
terraform plan
terraform apply
```

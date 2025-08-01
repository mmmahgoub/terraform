provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "myec2" {
  count         = 3
  ami           = "ami-085ad6ae776d8f09c" # Replace with a valid AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "my-aws-terraform-lab-${count.index + 1}"
  }
}

#resource "aws_instance" "windows_server" {
#  ami           = "ami-04f77c9cd94746b09"  # Windows Server 2025 AMI
#  instance_type = "t2.micro"
#
#  tags = {
#    Name = "windows-server-2025"
#  }
#}

resource "aws_instance" "rhel_machine" {
  ami           = "ami-0c7af5fe939f2677f" # RHEL AMI
  instance_type = "t2.micro"

  tags = {
    Name = "rhel-machine"
  }
}



provider "azurerm" {}
#redhat(ami-0c7af5fe939f2677f)
#windows server2025(ami-04f77c9cd94746b09)
provider "google" {
  project = "my-project-id"
  region  = "us-central1"
}
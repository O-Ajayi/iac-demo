terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

module "app_server" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "Jenkins-instance"

  ami                    = "ami-0a1eddae0b7f0a79f"
  instance_type          = "t4g.micro"
  key_name               = "jenkins-server"
  monitoring             = true
  vpc_security_group_ids = ["sg-0cd8267e17783dfef"]
  subnet_id              = "subnet-0748037c4eda61cd7"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Automation = "Jenkins"
  }
}

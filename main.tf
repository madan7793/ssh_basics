terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "bucket_name"
    region         = "us-east-1"
    key            = "environments/prod/ap-south-1/instance/terraform.tfstate"
    dynamodb_table = "terraform_lock"
  }
}

provider "aws" {
  region = var.region
}

# Get core infra data
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["test-vpc"]
  }
}

data "aws_subnets" "public_subnet_ids" {

  filter {
    name   = "tag:Name"
    values = ["test1","test2"]
  }
}

module "ec2" {
  source = "../modules/ec2-instance"

  region            = var.region
  vpc_id            = data.aws_vpc.vpc.id
  vpc_cidr          = data.aws_vpc.vpc.cidr_block
  public_subnet_ids = data.aws_subnets.public_subnet_ids.ids
  environment = var.environment
  s3_bucket   = var.s3_bucket
  hostname      = "test"
  instance_type = "t2.small"
  key_name      = "test"
  secondary_block_device            = false
  secondary_block_device_size_in_gb = 8
}

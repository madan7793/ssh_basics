output "environment" {
  value = var.environment
}

output "image_id" {
  value = module.ec2.image_id
}

output "public_ip" {
  value = module.ec2.public_ip
}

output "region" {
  value = var.region
}

output "s3_bucket" {
  value = var.s3_bucket
}

output "vpc_cidr" {
  value = data.aws_vpc.vpc.cidr_block
}

output "vpc_id" {
  value = data.aws_vpc.vpc.id
}

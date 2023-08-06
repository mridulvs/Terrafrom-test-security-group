provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

resource "aws_vpc" "existing_vpc" {
  # Add your existing VPC configuration here
}

locals {
  security_groups_data = jsondecode(file("${path.module}/security_groups_data.json"))
}

resource "aws_security_group" "custom" {
  count       = length(local.security_groups_data)
  name_prefix = local.security_groups_data[count.index].security_group_name
  description = local.security_groups_data[count.index].description
  vpc_id      = aws_vpc.existing_vpc.id

  ingress {
    from_port   = local.security_groups_data[count.index].from_port
    to_port     = local.security_groups_data[count.index].to_port
    protocol    = local.security_groups_data[count.index].protocol
    cidr_blocks = local.security_groups_data[count.index].cidr_blocks
  }

  # Add additional rules here as needed, e.g., for security group references
  # security_groups = local.security_groups_data[count.index].security_group_ids
}

provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source                = "./Modules/VPC"
  VPC_cidr_block        = var.VPC_cidr_block
  VPC_Name              = var.VPC_Name
  Public_cidr_block     = var.Public_cidr_block
  Public_subnet_Name    = var.Public_subnet_Name
  Public_RT_Name        = var.Public_RT_Name
  Private_cidr_block    = var.Private_cidr_block
  Private_subnet_Name   = var.Private_subnet_Name
  Private_RT_Name       = var.Private_RT_Name
  Internet_gateway_Name = var.Internet_gateway_Name
  Nat_gateway_Name      = var.Nat_gateway_Name
  ENV                   = var.ENV
  SG_Name               = var.SG_Name
  ingress_rule = {
    ssh = {
      type       = "egress"
      from_port  = 22
      to_port    = 22
      protocol   = "tcp"
      cidr_block = ["0.0.0.0/0"]

    }

    https = {
      type       = "egress"
      from_port  = 443
      to_port    = 443
      protocol   = "tcp"
      cidr_block = ["0.0.0.0/0"]
    }
  }
}

module "ec2" {
  for_each          = var.servers
  source            = "./Modules/EC2"
  EC2_Name          = each.key
  ami               = each.value.ami
  instance_type     = each.value.instance_type
  subnet_id         = module.vpc.Public_Subnet_id
  security_group_id = [module.vpc.SG_ID]
  ENV               = var.ENV
  root_block_device = {
    volume_size           = 20
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  extra_volumes = [{
    volume_size           = 70
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
    device_name           = "/dev/sdb"

  }]
}


resource "aws_instance" "sonar" {
  ami = "ami-00ca570c1b6d79f36"
  instance_type = "t3.small"
  subnet_id = var.Public_subnet_Name

  tags = {
    Name = "VAPT_server"
  }
  
}

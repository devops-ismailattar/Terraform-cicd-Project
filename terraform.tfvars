VPC_cidr_block = "10.0.0.0/16"

VPC_Name = "Terraform_VPC"

Public_cidr_block = "10.0.1.0/24"

Private_cidr_block = "10.0.2.0/24"

ENV = "DEV"

Private_subnet_Name = "Private_SUbnet_A"

Public_subnet_Name = "Public_Subnet_A"

Internet_gateway_Name = "ING_1"

Nat_gateway_Name = "NGW1"

Private_RT_Name = "Private_RT"

Public_RT_Name = "Public_RT"

SG_Name = "Terrafrom_SG"

servers = {
  "Node1" = {
    ami = "ami-00ca570c1b6d79f36"
    instance_type = "m7i-flex.large"
    
  }

  "Node2" = {
    ami = "ami-00ca570c1b6d79f36"
    instance_type = "t3.micro"
    
  }

  "Node3" = {
    ami = "ami-00ca570c1b6d79f36"
    instance_type = "t3.small"
    
  }
}
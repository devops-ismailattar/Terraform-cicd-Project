output "VPC_ID" {
  value = module.vpc.VPC_ID

}

output "Public_Subnet_id" {
  value = module.vpc.Public_Subnet_id

}

output "Private_Subnet_id" {
  value = module.vpc.Private_Subnet_id

}
output "ING_id" {
  value = module.vpc.ING_id
}

output "Nat_gateway_id" {
  value = module.vpc.Nat_gateway_id
}

output "Private_route_table_id" {
  value = module.vpc.Private_route_table_id
}

output "Public_route_table_id" {
  value = module.vpc.Public_route_table_id
}


output "SG_ID" {
  value = module.vpc.SG_ID
}

output "instance_id" {
  value = { for k, v in module.ec2 : k => v.instance_id }

}


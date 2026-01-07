output "VPC_ID" {
  value = aws_vpc.custom.id

}

output "Public_Subnet_id" {
  value = aws_subnet.Publicesubnet.id

}

output "Private_Subnet_id" {
  value = aws_subnet.Privatesubnet.id

}
output "ING_id" {
  value = aws_internet_gateway.IGW.id
}

output "Nat_gateway_id" {
  value = aws_nat_gateway.NGW.id
}

output "Private_route_table_id" {
  value = aws_route_table.PrivateRT.id
}

output "Public_route_table_id" {
  value = aws_route_table.PublicRT.id
}


output "SG_ID" {
  value = aws_security_group.CustomSG.id
}


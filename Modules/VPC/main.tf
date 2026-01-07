# VPC modules 


#-----------------VPC-------------#

resource "aws_vpc" "custom" {
  cidr_block = var.VPC_cidr_block

  tags = {
    Name = var.VPC_Name
    ENV  = var.ENV
  }
}

#-----------------PRIVATE SUBNET-------------#
resource "aws_subnet" "Privatesubnet" {
  cidr_block = var.Private_cidr_block
  vpc_id     = aws_vpc.custom.id

  tags = {
    Name = var.Private_subnet_Name
    ENV  = var.ENV
  }

}

#-----------------PUBLIC SUBNET-------------#
resource "aws_subnet" "Publicesubnet" {
  cidr_block              = var.Public_cidr_block
  vpc_id                  = aws_vpc.custom.id
  map_public_ip_on_launch = true

  tags = {
    Name = var.Public_subnet_Name
    ENV  = var.ENV
  }

}

#-----------------INTERNET GATEWAY-------------#
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.custom.id

  tags = {
    Name = var.Internet_gateway_Name
    ENV  = var.ENV
  }

}

#-----------------ELASTIC IP-------------#
resource "aws_eip" "EIP" {
  domain = "vpc"
}

#-----------------NAT GATEWAY-------------#
resource "aws_nat_gateway" "NGW" {
  allocation_id = aws_eip.EIP.id
  subnet_id     = aws_subnet.Publicesubnet.id

  tags = {
    Name = var.Nat_gateway_Name
    ENV  = var.ENV
  }

}
#-----------------PUBLIC ROUTE TABLE-------------#
resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.custom.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = var.Public_RT_Name
    ENV  = var.ENV
  }
}

#-----------------PRIVATE ROUTE TABLE------------#
resource "aws_route_table" "PrivateRT" {
  vpc_id = aws_vpc.custom.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NGW.id

  }
  tags = {
    Name = var.Private_RT_Name
    ENV  = var.ENV
  }
}

#-----------------PUBLIC ROUTE TABLE ASSOCIATION------------#
resource "aws_route_table_association" "PublicA" {
  subnet_id      = aws_subnet.Publicesubnet.id
  route_table_id = aws_route_table.PublicRT.id
}

#-----------------PRIVATE ROUTE TABLE ASSOCIATION------------#
resource "aws_route_table_association" "PrivateA" {
  subnet_id      = aws_subnet.Privatesubnet.id
  route_table_id = aws_route_table.PrivateRT.id

}

#-----------------SECURITY GROUP------------#
resource "aws_security_group" "CustomSG" {
  vpc_id      = aws_vpc.custom.id
  description = "Allow TLS inbound traffic and all outbound traffic"
  name        = "TerrafromSG"

  tags = {
    Name = var.SG_Name
    ENV  = var.ENV
  }


}

#-----------------SECURITY GROUP RULES------------#
resource "aws_security_group_rule" "Igress_rules" {
  for_each          = var.ingress_rule
  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_block
  security_group_id = aws_security_group.CustomSG.id

}



resource "aws_security_group_rule" "Egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.CustomSG.id
}

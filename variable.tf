variable "VPC_cidr_block" {
  type = string
}

variable "VPC_Name" {
  type = string
}

variable "ENV" {
  type = string
}

variable "Private_cidr_block" {
  type = string
}

variable "Private_subnet_Name" {
  type = string
}

variable "Public_cidr_block" {
  type = string
}

variable "Public_subnet_Name" {
  type = string
}


variable "Internet_gateway_Name" {
  type = string
}

variable "Nat_gateway_Name" {
  type = string
}

variable "Private_RT_Name" {
  type = string
}

variable "Public_RT_Name" {
  type = string
}

variable "SG_Name" {
  type = string
}

variable "servers" {
  type = map(object({
    ami           = string
    instance_type = string
  }))

}
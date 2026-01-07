variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "subnet_id" {
  type = string
}

variable "ENV" {
  type = string
  
}
variable "security_group_id" {
  type = list(string)
  default = []
}

variable "EC2_Name" {
  type = string
}

variable "root_block_device" {
  type = object({
    volume_type = string
    volume_size = number
    encrypted = bool
    delete_on_termination = bool
  })
}

variable "extra_volumes" {
  type = list(object({
    volume_type = string
    volume_size = number
    encrypted = bool
    delete_on_termination = bool
    device_name = string
    
  }))
  
}
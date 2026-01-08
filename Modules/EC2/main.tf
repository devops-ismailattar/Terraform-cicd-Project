
#------------------------EC2 Servers---------------------------#

resource "aws_instance" "servers" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_id

  #------------------------Root Volume configuration----------------#
  root_block_device {
    volume_size           = var.root_block_device.volume_size
    volume_type           = var.root_block_device.volume_type
    encrypted             = var.root_block_device.encrypted
    delete_on_termination = var.root_block_device.delete_on_termination
  }

  #------------------------Extra disk for servers---------------------------#
  dynamic "ebs_block_device" {
    for_each = var.extra_volumes
    content {
      device_name           = ebs_block_device.value.device_name
      volume_size           = ebs_block_device.value.volume_size
      volume_type           = ebs_block_device.value.volume_type
      encrypted             = ebs_block_device.value.encrypted
      delete_on_termination = ebs_block_device.value.delete_on_termination
    }
  }

  tags = {
    Name = var.EC2_Name
    ENV  = var.ENV
  }
}
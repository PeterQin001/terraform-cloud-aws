######################
#  main.tf
########################
provider "aws" {
  region  = "us-east-1"
}

#resource aws_transfer_server aws-api {

#  disable_dependent_services = true
#  disable_on_destroy         = false

# }

#resource "null_resource" "resource-to-wait-on" {
#  provisioner "local-exec" {
#    command = sleep $local.wait-time
#  }
#  depends_on = ["aws_transfer_server.aws-api"]
#}




#resource "aws_transfer_ssh_key" "transfer_server_ssh_key" {
#  disable_dependent_services = true
#   for_each =  var.transfer_server_user_key
# count = length(var.transfer_server_user_key)

#  server_id = var.transfer_server

#    body      = each.value
#    user_name = each.key
#   user_name = var.aws_transfer_user.transfer_server_user.*.each.key
#    user_name = element(aws_transfer_user.transfer_server_user.*.user_name, count.index)
#   body      = element(var.transfer_server_ssh_key, count.index)
#   body      = each.value
#}


resource "aws_transfer_user" "transfer_server_user" {

 for_each = var.transfer_server_user_key

# count = length(var.transfer_server_user)

  server_id      = var.transfer_server
  user_name      = each.key
  role           = var.transfer_server_role
  home_directory_type = "LOGICAL"
  home_directory_mappings {
    entry =  "/"
    target = "/${var.bucket_name}"
 }

}

resource "aws_transfer_ssh_key" "transfer_server_ssh_key" {
  for_each =  var.transfer_server_user_key
#  count = length(var.transfer_server_user)

  server_id = var.transfer_server

   body      = each.value
   user_name = each.key
#   user_name = var.aws_transfer_user.transfer_server_user.*.each.key
#   user_name = element(aws_transfer_user.transfer_server_user.*.user_name, count.index)
#   body      = element(var.transfer_server_ssh_key, count.index)
#   body      = each.value
}

###############################
# vars.tf define variables
#################################
variable  "transfer_server" {
    description = "Transfer_server"
    type = string
    default = "s-ad41f033819941279"
}
variable "bucket_name" {
    description = " S3 bucket name"
    type = string
    default = "ohiobucket2/folder2"
}

variable  "transfer_server_role" {
    description = "Transfer_server"
    type = string
    default = "arn:aws:iam::013700525790:role/role_ohb"

}

#############################################
# input user and key date in map format
#############################################
variable "transfer_server_user_key"  {
    description = "Transfer_server_user_key"
    type = map
#   default = {
#      sftpuser1 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqGRwso/n1IdjVLL4L6x0i76fXZ+It1mX+zGVNQdCPYFD6fnp/txBjcoVEMKGTq5Hh8hLEtSl8oiJzD4fs7EOJn9q+LFSs10QB0RLuybYyOkerQ+6fddFGf1bLBR8T+DMe55JEmEW4QMKuO0kwdojeOMWj6bA77iY1QkIV52S2xvPPSNFUe9NDAYIawUADUrhOfUIzzVXijOnI5tqBLByDvBC0inDBRDkMykgAnZJ4D9v9xC1mp0scuQ7CR2MBwL594WPMAvRiOLKrBa97qaezpyVFyiADoENcgww584VaYEc1KG/T8OpOWj+P/pvzJW6LPF"
#  sftpuser2 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDVYPSwbPyseqaj1BNKACuNRtZ0v2ZHPTpqI8isy0XLmnNQsAM6M6X1beOeAeP+PMTQbJkUUxzhDbsdjHre84xtOAYpoo5TIsPOrvwUqsd6N6hTpxvvNMH77raOdShjLRN9KL2tMunJKDqTdHVHpy6OYEVmSC2nnc/ykWVGpBYxXmh6UMpNLXeOUfce2yLMbNDfVGgCBDDyKEi2zTI8i+EgztyDX0KveWb3GCB5ak0eXVZc8eZ4DpjXEP5hPBf7a2HEqle78992zRCBy/UaNJXjJo8GNCLr731zMzsSmYJGxvQn7KKh/jTMXWvpzgh/fkt8fYDxob3OGcu3IaaO2JvMg0xt2aNpybSCn32qIh/N3DF4LJsii366VPtYgpwsow+XTpPNv82rkftuf9TCe2HbTfnII2Ddhhpy1kGu13H31XV2Rm6V7PBi3CFyKXepd5DT/jRtF89GyMJT+TIyYkjtON4gxnuB64hgPc3du5Fw1fWqS/Qry8T2w2INK6zj7IE= ubuntu@ip-10-0-1-234"
#   ftpuser3 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDE9p4hZ/8ZaYGjgSXHVtv8Iao2FadjJzKSOmOHSw0RMfYznkMeQRuabfaNV6QN6IU667plxZMXDPwTyZYrmC7md4bymcMs4BqHybFGZl3dWFh9rpkihjEXmg/x1MVcipWQs8PlWIpSRGHvEo5DC0bhu0ficexWYHf3DX1qTYX8tDC4aNeiTO4lHnXug/3wn6tBJhjPWM9awiGWe3w1wtFymU9F7LYbCMLZPexdsbqMIBFjMEFBgoTcYR9bloRrp3aKTgoAJrwBnbFIh/0PkGhE61eehrdObwPGLEb/Objv1IgeN4ViDgJhpB7u125Ib347rCiViFpqQjTDJ4D85x2R ec2-user@ip-10-0-1-82.ec2.internal"
#  }
}


variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "ap-southeast-2"
}

variable "availability_zone" {
  description = "The AWS availability zone where resources will be created"
  type        = string
  default     = "ap-southeast-2c"
}

variable "instance_ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-09e143e99e8fa74f9" # Ubuntu 24.04
#   default     = "ami-0b0a3a2350a9877be" # Amazon Linux 2023
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
  default     = "t3.medium"
}

variable "key_pair_name" {
  description = "The name of the EC2 key pair"
  type        = string
  default     = "prefect_server"
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "prefect_security_group"
}

variable "storage_size_gb" {
  description = "The size of the EBS volume in GB"
  type        = number
  default     = 20
}

variable "ebs_volume_type" {
  description = "The type of EBS volume"
  type        = string
  default     = "gp3"
}

variable "instance_device_name" {
  description = "The device name for the EBS volume attachment"
  type        = string
  default     = "/dev/sdh"
}
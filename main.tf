terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

# define security group and ingress/egress rules
resource "aws_security_group" "prefect_security_group" {
  name        = var.security_group_name
  description = "Allow HTTP and SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 4200
    to_port     = 4200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance to deploy Prefect onto
resource "aws_instance" "prefect_server" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  availability_zone           = var.availability_zone
  associate_public_ip_address = true
  user_data                   = data.template_file.prefect_install.rendered
  key_name                    = data.aws_key_pair.prefect_key.key_name
  vpc_security_group_ids      = [aws_security_group.prefect_security_group.id]

  tags = {
    Name = "prefect-orchestrator-server"
  }
}

# Create a separate volume in case we ever need to destroy and recreate the instance. We need the data!
# In case you change the size of the EBS volume, you need to SSH into the EC2 instance, confirm extra block size (`lsblk`), then run `sudo resize2fs /dev/nvme1n1` to fill up the new space
resource "aws_ebs_volume" "prefect_storage" {
  availability_zone = var.availability_zone
  size              = var.storage_size_gb
  type              = var.ebs_volume_type

  tags = {
    Name = "Prefect Storage"
  }
}

resource "aws_volume_attachment" "prefect_attachment" {
  volume_id   = aws_ebs_volume.prefect_storage.id
  instance_id = aws_instance.prefect_server.id
  device_name = var.instance_device_name
}
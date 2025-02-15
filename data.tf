data "template_file" "prefect_install" {
  template = file("install_prefect.tpl")
}

# TODO: Create an EC2 key pair with the name "prefect_server" and tag "name:prefect-server"
data "aws_key_pair" "prefect_key" {
  key_name           = var.key_pair_name
  include_public_key = true

  filter {
    name   = "tag:name"
    values = [var.key_pair_name]
  }
}
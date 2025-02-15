# prefect-terraform-deployment
Terraform scripts to deploy Prefect onto AWS EC2.  

The files were based on the Medium article below but adapted to my needs. Running `terraform init`, `terraform plan`, `terraform apply` will deploy an EC2 instance based on Ubuntu 24.04. `install_prefect.tpl` is a user_data script that runs on first start of the EC2 instance, and will install the necessary libraries + prefect.

`output.tf` spits out the public dns and public ip of the EC2 instance, as well as the ssh commands to login and port-forward to the prefect server. 

You will need to first create a key-pair named `prefect_server` in AWS (and tagged with `name:prefect_server`).

Credits: https://medium.com/@kelvingakuo/self-hosting-prefect-on-aws-ec2-managed-via-terraform-and-prefect-yaml-53f2795f6e4c#786f  

TODO: 
1. Run some code
2. Deploy flows from git repo
3. Rework docker work pools into ECS work pools

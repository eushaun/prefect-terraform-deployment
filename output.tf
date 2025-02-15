output "ssh_command" {
  description = "SSH command to connect to Prefect server"
  value       = "ssh -i prefect_server.pem ubuntu@${aws_instance.prefect_server.public_dns}"
}

output "connect_to_prefect" {
  description = "Port forward command to connect to Prefect"
  value       = "ssh -i prefect_server.pem -L 4200:localhost:4200 -N -f ubuntu@${aws_instance.prefect_server.public_dns}"
}

output "first_run_logs" {
  description = "Running logs for install_prefect.tpl script"
  value       = "tail -F /var/log/cloud-init-output.log"
}

output "ec2_public_dns" {
  description = "The public dns of the created EC2 instance"
  value       = aws_instance.prefect_server.public_dns
}

output "ec2_public_ip" {
  description = "The public IP address of the created EC2 instance"
  value       = aws_instance.prefect_server.public_ip
}
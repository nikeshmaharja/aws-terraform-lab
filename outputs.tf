
# Output the public IP address of the EC2 instance
output "instance_public_ip" {
  value = aws_instance.free_tier_instance.public_ip   # Reference the instance's public IP

}


# Output the path to the generated private key file
output "private_key_path" {
  value = local_file.private_key.filename # Path to the .pem file saved locally
}
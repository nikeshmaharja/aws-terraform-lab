output "instance_public_ip" {
  value = aws_instance.free_tier_instance.public_ip

}

output "private_key_path" {
  value = local_file.private_key.filename
}
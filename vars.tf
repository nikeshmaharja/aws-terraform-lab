variable "instance_type" {
  description = "EC2 instance type test"
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  default     = "aws-lab-key"
}
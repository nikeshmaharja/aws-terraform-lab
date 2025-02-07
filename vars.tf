
# Define the EC2 instance type variable
variable "instance_type" {
  description = "EC2 instance type test"
  default     = "t2.micro"                  # Default value (free-tier eligible)
}


variable "key_name" {
  description = "SSH key pair name"
  default     = "aws-lab-key"                   # Default name for the AWS key pair
}
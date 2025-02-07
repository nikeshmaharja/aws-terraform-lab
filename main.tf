# Creating an AWS key pair
resource "aws_key_pair" "lab_key" {                                 
  key_name   = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh
}

# Generate an SSH key pair using the TLS provider
resource "tls_private_key" "rsa" {                                  
  algorithm = "RSA"                                 # Use RSA algorithm for key generation
  rsa_bits  = 4096                                  # Create a 4096-bit key for enhanced security
}


# Create an EC2 instance using the free-tier eligible t2.micro instance type
resource "aws_instance" "free_tier_instance" {
  ami           = "ami-0a290015b99140cd1"           # Ubuntu 24 (AMI) ID for the instance  (AMI ID depends upon on the region so change accordingly)
  instance_type = "t2.micro"                        # Instance type (free-tier eligible)
  key_name      = aws_key_pair.lab_key.key_name     # Attach the SSH key pair to the instance


# Attach the security group to control inbound/outbound traffic
  security_groups = [aws_security_group.lab_test.name]


# Add tags to the instance for better identification
  tags = {
    Name = "Linux-Terra-AWS-TEST"
  }
}

# Create a security group to control access to the EC2 instance
resource "aws_security_group" "lab_test" {
  name        = "lab-security-group"                # Name of the security group
  description = "Allow SSH access"                  # Description of the security group's purpose


# Ingress rule: Allow SSH access (port 22) only from your current IP address
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }


# Egress rule: Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Fetch your current public IP address using an HTTP data source
data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}


# Save the private key to a local file for SSH access
resource "local_file" "private_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "${var.key_name}.pem"
}
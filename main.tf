resource "aws_key_pair" "lab_key" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_instance" "free_tier_instance" {
  ami           = "ami-0a290015b99140cd1"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.lab_key.key_name

  security_groups = [aws_security_group.lab_test.name]

  tags = {
    Name = "Linux-Terra-AWS-TEST"
  }
}

resource "aws_security_group" "lab_test" {
  name        = "lab-security-group"
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

resource "local_file" "private_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "${var.key_name}.pem"
}
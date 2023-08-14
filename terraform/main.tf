# Provider configuration (e.g., for AWS)
provider "aws" {
  region = "us-west-1"  # Change this to your desired region
}

# Define a simple AWS EC2 instance
resource "aws_instance" "my_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Change this to your desired AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "MyInstance"
  }
}

# Define a security group
resource "aws_security_group" "my_sg" {
  name        = "my-security-group"
  description = "My Security Group"

  ingress {
    from_port   = 80  # Change this to your desired port
    to_port     = 80  # Change this to your desired port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change this to restrict access as needed
  }
}

# Output the public IP of the instance
output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}


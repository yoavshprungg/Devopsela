provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "nginx" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  user_data = <<-EOF
              yum update -y
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "nginx-instance"
  }

  vpc_security_group_ids = ["sg-0a07c4899c3d39521"]
}

resource "aws_security_group_rule" "nginx_http_ingress" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

output "nginx_public_ip" {
  value = aws_instance.nginx.public_ip
}


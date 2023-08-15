provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  count         = var.instance_count
  ami           = "ami-0c55b159cbfafe1f0" # Example Amazon Linux 2 AMI
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index]
  security_groups = var.security_group_ids

  tags = {
    Name = "ExampleInstance-${count.index}"
  }
}


variable "region" {
  description = "AWS region"
  default     = "us-west-1"  # Change this to your desired region
}

variable "ami_id" {
  description = "AMI ID for the instance"
  default     = "ami-0c55b159cbfafe1f0"  # Change this to your desired AMI ID
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "security_group_ingress_port" {
  description = "Ingress port for the security group"
  default     = 80  # Change this to your desired port
}

variable "security_group_cidr_blocks" {
  description = "CIDR blocks for the security group"
  default     = ["0.0.0.0/0"]  # Change this to restrict access as needed
}

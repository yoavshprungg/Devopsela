# Define variables for your Terraform project

variable "region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "instance_count" {
  description = "Number of instances to create."
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "Instance type for the EC2 instances."
  type        = string
  default     = "t2.micro"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the instances."
  type        = list(string)
  default     = ["subnet-abc123", "subnet-def456"]
}

variable "security_group_ids" {
  description = "List of security group IDs for the instances."
  type        = list(string)
  default     = ["sg-abc123", "sg-def456"]
}


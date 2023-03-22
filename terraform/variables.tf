variable "aws_region" {
  type        = string
  default     = "us-west-1"
  description = "AWS region"
}

variable "ami_id" {
  type        = string
  description = "Which ami to use for the ec2 instance"
  default     = "ami-0d50e5e845c552faf"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Size of the ec2 instance"
}

#variable "key_name" {
#  type        = string
#  default     = "test_key"
#  description = "Name of an ssh key that is registered on AWS for instance ssh access"
#}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16" #"172.31.0.0/16"
  description = "The VPC cidr_block range"
}

variable "subnet_cidr_block" {
  type        = string
  default     = "10.0.1.0/24" #"172.31.0.0/20"
  description = "The subnet cidr_block range"
}
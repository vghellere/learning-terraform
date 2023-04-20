variable "region" {
  description = "region to use for AWS resources"
  type        = string
  default     = "us-east-1"
}

variable "region_a" {
  description = "The region the environment is going to be installed into"
  type        = string
  default     = "us-east-1a"
}

variable "vpc_cidr" {
  description = "CIDR range for created VPC"
  type        = string
  default     = "10.0.0.0/25"
}

variable "private_cidr_a" {
  description = "CIDR range for created VPC"
  type        = string
  default     = "10.0.0.0/26"
}

variable "public_cidr_a" {
  description = "CIDR range for created VPC"
  type        = string
  default     = "10.0.0.64/26"
}

variable "access_key" {
  type      = string
  sensitive = true
}

variable "secret_access_key" {
  type      = string
  sensitive = true
}
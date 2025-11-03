variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type        = string
  description = "Region where resources will be created"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC network"
  default     = "main-vpc"
}

variable "management_subnet_cidr" {
  type        = string
  description = "CIDR for the management subnet"
}

variable "restricted_subnet_cidr" {
  type        = string
  description = "CIDR for the restricted subnet"
}

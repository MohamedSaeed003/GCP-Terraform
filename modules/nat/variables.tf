variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "network" {
  type        = string
  description = "VPC network self link"
}

variable "router_name" {
  type        = string
  default     = "nat-router"
}

variable "nat_name" {
  type        = string
  default     = "nat-gateway"
}

variable "management_subnet" {
  type        = string
  description = "Self link of the management subnet to attach NAT"
}

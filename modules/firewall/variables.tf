variable "firewall_name" {
  type        = string
  description = "Name of the firewall rule"
}

variable "network" {
  type        = string
  description = "Network to which the rule applies"
}
variable "management_subnet_cidr" {
  type = string
}
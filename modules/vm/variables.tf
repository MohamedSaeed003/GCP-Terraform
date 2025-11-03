variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "subnet_self_link" {
  type        = string
  description = "Management subnet self link"
}

variable "vm_name" {
  type        = string
  default     = "private-vm"
}

variable "machine_type" {
  type        = string
  default     = "e2-micro"
}

variable "tags" {
  type        = list(string)
  default     = ["management", "allow-iap", "allow-https"]
}

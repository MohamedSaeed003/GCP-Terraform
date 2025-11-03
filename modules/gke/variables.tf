variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "network" {
  type = string
  description = "VPC network self link"
}

variable "subnet" {
  type = string
  description = "Restricted subnet self link"
}

variable "cluster_name" {
  type    = string
  default = "private-gke-cluster"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "node_service_account_email" {
  type        = string
  description = "Email of the custom service account used by GKE nodes"
}

variable "master_ipv4_cidr_block" {
  type        = string
  default     = "172.16.0.0/28"
  description = "CIDR block for GKE control plane (private master)"
}

variable "authorized_networks" {
  type = list(object({
    name  = string
    cidr  = string
  }))
  default = []
}

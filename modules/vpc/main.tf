resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  project                 = var.project_id
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

# Management subnet
resource "google_compute_subnetwork" "management" {
  name                  = "${var.vpc_name}-management-subnet"
  project               = var.project_id
  region                = var.region
  ip_cidr_range         = var.management_subnet_cidr
  network               = google_compute_network.vpc.id
  private_ip_google_access = true

  # Optional secondary ranges for GKE later
  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.10.0.0/16"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.20.0.0/20"
  }
}

# Restricted subnet
resource "google_compute_subnetwork" "restricted" {
  name                  = "${var.vpc_name}-restricted-subnet"
  project               = var.project_id
  region                = var.region
  ip_cidr_range         = var.restricted_subnet_cidr
  network               = google_compute_network.vpc.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = "10.30.0.0/16"
  }

  secondary_ip_range {
    range_name    = "gke-services"
    ip_cidr_range = "10.40.0.0/20"
  }
}

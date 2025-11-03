module "vpc" {
  source                 = "./modules/vpc"
  project_id             = var.project_id
  region                 = var.region
  vpc_name               = "lab-vpc"
  management_subnet_cidr = "10.0.1.0/24"
  restricted_subnet_cidr = "10.0.2.0/24"
}
module "nat" {
  source            = "./modules/nat"
  project_id        = var.project_id
  region            = var.region
  network           = module.vpc.vpc_id
  management_subnet = module.vpc.management_subnet
}


module "vm" {
  source           = "./modules/vm"
  project_id       = var.project_id
  region           = var.region
  zone             = "us-central1-a"
  subnet_self_link = module.vpc.management_subnet
  vm_name          = "private-vm"
}
module "firewall_iap_ssh" {
  source        = "./modules/firewall"
  firewall_name = "allow-iap-ssh"
  network       = module.vpc.vpc_id
  management_subnet_cidr = "10.0.1.0/24"
}
# GKE node service account
resource "google_service_account" "gke_nodes_sa" {
  account_id   = "gke-node-sa"
  display_name = "Service Account for GKE Nodes"
  project      = var.project_id
}

resource "google_project_iam_member" "gke_node_sa_roles" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/artifactregistry.reader",
    "roles/container.nodeServiceAgent",
    "roles/compute.viewer"
  ])

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.gke_nodes_sa.email}"
}

module "gke" {
  source                     = "./modules/gke"
  project_id                 = var.project_id
  region                     = var.region
  network                    = module.vpc.vpc_id
  subnet                     = module.vpc.restricted_subnet
  node_service_account_email = google_service_account.gke_nodes_sa.email
  authorized_networks = [
    {
      name = "management"
      cidr = "10.0.1.0/24" # only management subnet can reach GKE control plane
    }
  ]
}
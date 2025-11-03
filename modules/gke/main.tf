resource "google_container_cluster" "gke" {
  name       = var.cluster_name
  location   = var.zone
  project    = var.project_id
  network    = var.network
  subnetwork = var.subnet

  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pods"
    services_secondary_range_name = "gke-services"
  }

  networking_mode = "VPC_NATIVE"

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.authorized_networks
      content {
        display_name = cidr_blocks.value.name
        cidr_block   = cidr_blocks.value.cidr
      }
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_container_node_pool" "nodes" {
  name       = "${var.cluster_name}-node-pool"
  project    = var.project_id
  location   = google_container_cluster.gke.location
  cluster    = google_container_cluster.gke.name

  node_count = 1

  node_config {
    machine_type    = "e2-medium"
    # disk_type       = "pd-standard"
    disk_size_gb    = 20
    service_account = var.node_service_account_email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      env = "restricted"
    }

    tags = ["restricted", "gke-nodes"]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

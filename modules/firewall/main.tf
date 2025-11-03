resource "google_compute_firewall" "allow_iap_ssh_home" {
  name    = var.firewall_name
  network = var.network

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]

  target_tags = ["allow-iap"]
}
resource "google_compute_firewall" "allow_egress_https" {
  name    = "allow-egress-https"
  network = var.network

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = [var.management_subnet_cidr]
  target_tags = ["allow-https"]
}

output "vpc_id" {
  value = google_compute_network.vpc.id
}

output "management_subnet" {
  value = google_compute_subnetwork.management.id
}

output "restricted_subnet" {
  value = google_compute_subnetwork.restricted.id
}

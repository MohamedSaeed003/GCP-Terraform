output "private_vm_name" {
  value = google_compute_instance.vm.name
}

output "private_vm_internal_ip" {
  value = google_compute_instance.vm.network_interface[0].network_ip
}

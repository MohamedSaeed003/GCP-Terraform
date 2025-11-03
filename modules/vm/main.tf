resource "google_compute_instance" "vm" {
  name         = var.vm_name
  project      = var.project_id
  zone         = var.zone
  machine_type = var.machine_type
  tags         = var.tags

  allow_stopping_for_update = true 

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = var.subnet_self_link
    # no access_config → no external IP → private-only
  }

  metadata = {
    ssh-keys = "terraform:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDemoKey terraform"  
  }

  service_account {
    email  = "default"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
}

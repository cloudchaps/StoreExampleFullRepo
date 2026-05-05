resource "google_compute_instance" "this" {
  count = var.instance_count

  name         = "${var.project_name}-${var.environment}-web-${count.index + 1}"
  project      = var.gcp_project_id
  zone         = var.zone
  machine_type = var.machine_type

  tags = var.network_tags

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = var.subnet_id

    # Public IP for testing.
    # Remove this block if instances should be private behind Cloud NAT/LB only.
    access_config {}
  }

  metadata_startup_script = file("${path.module}/startup.sh")

  labels = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform"
  }
}
resource "google_compute_router" "this" {
  name    = "${var.project_name}-${var.environment}-router"
  project = var.gcp_project_id
  region  = var.region
  network = google_compute_network.cloudchaps_compute_network.id
}

resource "google_compute_address" "nat" {
  name    = "${var.project_name}-${var.environment}-nat-ip"
  project = var.gcp_project_id
  region  = var.region
}

resource "google_compute_router_nat" "this" {
  name    = "${var.project_name}-${var.environment}-cloud-nat"
  project = var.gcp_project_id
  region  = var.region
  router  = google_compute_router.this.name

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = [google_compute_address.nat.self_link]

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  dynamic "subnetwork" {
    for_each = var.nat_subnet_keys

    content {
      name                    = google_compute_subnetwork.cloudchaps_compute_subnetwork[subnetwork.value].id
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  }
}
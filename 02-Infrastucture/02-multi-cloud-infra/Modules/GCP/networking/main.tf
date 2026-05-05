resource "google_compute_network" "cloudchaps_compute_network" {
  name                    = "${var.project_name}-${var.environment}-vpc"
  project                 = var.gcp_project_id
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}
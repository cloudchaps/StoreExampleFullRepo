resource "google_compute_subnetwork" "cloudchaps_compute_subnetwork" {
  for_each = var.subnets

  name                     = each.value.name
  project                  = var.gcp_project_id
  region                   = var.region
  network                  = google_compute_network.cloudchaps_compute_network.id
  ip_cidr_range            = each.value.ip_cidr_range
  private_ip_google_access = each.value.private_ip_google_access
}
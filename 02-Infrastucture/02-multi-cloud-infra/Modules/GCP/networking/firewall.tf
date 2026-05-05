resource "google_compute_firewall" "cloudchaps_compute_firewall" {
  for_each = var.firewall_rules

  name    = each.value.name
  project = var.gcp_project_id
  network = google_compute_network.cloudchaps_compute_network.name

  direction     = each.value.direction
  source_ranges = each.value.source_ranges
  target_tags   = each.value.target_tags

  allow {
    protocol = each.value.protocol
    ports    = each.value.ports
  }
}
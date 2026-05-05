output "vpc_id" {
  value = google_compute_network.cloudchaps_compute_network.id
}

output "vpc_name" {
  value = google_compute_network.cloudchaps_compute_network.name
}

output "subnet_ids" {
  value = {
    for key, subnet in google_compute_subnetwork.cloudchaps_compute_subnetwork :
    key => subnet.id
  }
}

output "subnet_names" {
  value = {
    for key, subnet in google_compute_subnetwork.cloudchaps_compute_subnetwork :
    key => subnet.name
  }
}
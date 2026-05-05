output "instance_names" {
  value = google_compute_instance.this[*].name
}

output "instance_private_ips" {
  value = google_compute_instance.this[*].network_interface[0].network_ip
}

output "instance_self_links" {
  value = google_compute_instance.this[*].self_link
}
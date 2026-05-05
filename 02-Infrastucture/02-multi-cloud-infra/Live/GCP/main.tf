module "networking" {
  source = "../../Modules/GCP/networking"

  project_name    = var.project_name
  environment     = var.environment
  gcp_project_id  = var.gcp_project_id
  region          = var.region
  subnets         = var.subnets
  firewall_rules  = var.firewall_rules
  nat_subnet_keys = var.nat_subnet_keys
}

module "compute" {
  source = "../../Modules/GCP/compute"

  project_name   = var.project_name
  environment    = var.environment
  gcp_project_id = var.gcp_project_id
  zone           = var.zone
  instance_count = 3
  machine_type   = var.machine_type
  subnet_id      = module.networking.subnet_ids["public_1"]
  network_tags   = ["web"]
}
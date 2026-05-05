module "resource_groups" {
  source = "../../Modules/Azure/resource-groups"

  resource_groups         = var.resource_groups
}

module "networking" {
  source = "../../Modules/Azure/networking"

  resource_group_name = module.resource_groups.resource_group_names["networking"]
  location            = module.resource_groups.resource_group_locations["networking"]
  
  project_name            = var.project_name
  environment             = var.environment
  address_space           = var.address_space
  subnets                 = var.subnets
  network_security_groups = var.network_security_groups
  subnet_nsg_associations = var.subnet_nsg_associations
  route_tables                  = var.route_tables
  subnet_route_table_associations = var.subnet_route_table_associations
  nat_gateway_subnet_associations = var.nat_gateway_subnet_associations
}

module "compute" {
  source = "../../Modules/Azure/compute"

  resource_group_name     = module.resource_groups.resource_group_names["compute"]
  location                = module.resource_groups.resource_group_locations["compute"]

  project_name            = var.project_name
  environment             = var.environment
  public_subnet_id        = module.networking.subnet_ids["public_1"]
  vm_count                = 3
  admin_username          = var.admin_username
  ssh_public_key          = var.ssh_public_key
}
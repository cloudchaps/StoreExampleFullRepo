output "resource_group_names" {
  value = {
    for key, rg in azurerm_resource_group.cloudchaps_store_rg :
    key => rg.name
  }
}

output "resource_group_locations" {
  value = {
    for key, rg in azurerm_resource_group.cloudchaps_store_rg :
    key => rg.location
  }
}

output "resource_group_ids" {
  value = {
    for key, rg in azurerm_resource_group.cloudchaps_store_rg :
    key => rg.id
  }
}
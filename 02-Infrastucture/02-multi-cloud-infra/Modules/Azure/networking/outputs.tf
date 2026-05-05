output "vnet_name" {
  value = azurerm_virtual_network.cloudchaps_store_vnet.name
}

output "vnet_id" {
  value = azurerm_virtual_network.cloudchaps_store_vnet.id
}

output "subnet_ids" {
  value = {
    for key, subnet in azurerm_subnet.cloudchaps_store_subnets :
    key => subnet.id
  }
}

output "subnet_names" {
  value = {
    for key, subnet in azurerm_subnet.cloudchaps_store_subnets :
    key => subnet.name
  }
}
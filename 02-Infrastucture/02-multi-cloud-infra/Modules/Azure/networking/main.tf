resource "azurerm_virtual_network" "cloudchaps_store_vnet" {
  name                = "${var.project_name}-${var.environment}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_subnet" "cloudchaps_store_subnets" {
  for_each = var.subnets

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.cloudchaps_store_vnet.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_network_security_group" "cloudchaps_store_nsg" {
  for_each = var.network_security_groups

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = each.value.security_rules

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_subnet_network_security_group_association" "cloudchaps_store_nsg_association" {
  for_each = var.subnet_nsg_associations

  subnet_id                 = azurerm_subnet.cloudchaps_store_subnets[each.value.subnet_key].id
  network_security_group_id = azurerm_network_security_group.cloudchaps_store_nsg[each.value.nsg_key].id
}

resource "azurerm_public_ip" "nat_public_ip" {
  name                = "${var.project_name}-${var.environment}-nat-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_nat_gateway" "cloudchaps_store_nat_gateway" {
  name                = "${var.project_name}-${var.environment}-nat-gw"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_nat_gateway_public_ip_association" "cloudchaps_store_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.cloudchaps_store_nat_gateway.id
  public_ip_address_id = azurerm_public_ip.nat_public_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "cloudchaps_nat_association" {
  for_each = var.nat_gateway_subnet_associations

  subnet_id      = azurerm_subnet.cloudchaps_store_subnets[each.value.subnet_key].id
  nat_gateway_id = azurerm_nat_gateway.cloudchaps_store_nat_gateway.id
}

resource "azurerm_route_table" "cloudchaps_store_route_tables" {
  for_each = var.route_tables

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "route" {
    for_each = each.value.routes

    content {
      name           = route.value.name
      address_prefix = route.value.address_prefix
      next_hop_type  = route.value.next_hop_type
    }
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_subnet_route_table_association" "cloudchaps_store_route_table_association" {
  for_each = var.subnet_route_table_associations

  subnet_id      = azurerm_subnet.cloudchaps_store_subnets[each.value.subnet_key].id
  route_table_id = azurerm_route_table.cloudchaps_store_route_tables[each.value.route_table_key].id
}
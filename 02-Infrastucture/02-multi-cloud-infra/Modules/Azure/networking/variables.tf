variable "resource_group_name" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnets" {
  description = "Map of subnets to create inside the VNet"
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "network_security_groups" {
  description = "Map of Azure Network Security Groups and their security rules"
  type = map(object({
    name = string
    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}

variable "subnet_nsg_associations" {
  description = "Map of subnet to NSG associations"
  type = map(object({
    subnet_key = string
    nsg_key    = string
  }))
}

variable "route_tables" {
  type = map(object({
    name = string
    routes = list(object({
      name           = string
      address_prefix = string
      next_hop_type  = string
    }))
  }))
}

variable "subnet_route_table_associations" {
  type = map(object({
    subnet_key      = string
    route_table_key = string
  }))
}

variable "nat_gateway_subnet_associations" {
  type = map(object({
    subnet_key = string
  }))
}

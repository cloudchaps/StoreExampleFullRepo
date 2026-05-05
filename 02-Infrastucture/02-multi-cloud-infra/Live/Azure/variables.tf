variable "subscription_id" {}
variable "tenant_id" {}

variable "project_name" {}
variable "environment" {}
variable "location" {}

variable "address_space" {
  type = list(string)
}

variable "subnets" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "network_security_groups" {
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

variable "admin_username" {
  type = string
}

variable "ssh_public_key" {
  type      = string
  sensitive = true
}

variable "resource_groups" {
  type = map(object({
    project_name        = string
    project_environment = string
    project_location    = string
    resource_type       = string
  }))
}
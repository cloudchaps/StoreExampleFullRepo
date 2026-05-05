variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "gcp_project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "subnets" {
  type = map(object({
    name                     = string
    ip_cidr_range            = string
    private_ip_google_access = bool
  }))
}

variable "firewall_rules" {
  type = map(object({
    name          = string
    direction     = string
    source_ranges = list(string)
    target_tags   = list(string)
    protocol      = string
    ports         = list(string)
  }))
}

variable "nat_subnet_keys" {
  type = set(string)
}
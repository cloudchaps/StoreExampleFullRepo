variable "resource_groups" {
  description = "Map of resource groups"
  type = map(object({
    project_name        = string
    project_environment = string
    project_location    = string
    resource_type       = string
  }))
}
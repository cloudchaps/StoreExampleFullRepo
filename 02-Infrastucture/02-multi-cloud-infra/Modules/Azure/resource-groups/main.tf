resource "azurerm_resource_group" "cloudchaps_store_rg" {
  for_each = var.resource_groups

  name     = "${each.value.project_name}-${each.value.project_environment}--${each.value.resource_type}-rg"
  location = each.value.project_location

  tags = {
    Project     = each.value.project_name
    Environment = each.value.project_environment
    ManagedBy   = "Terraform"
  }
} 
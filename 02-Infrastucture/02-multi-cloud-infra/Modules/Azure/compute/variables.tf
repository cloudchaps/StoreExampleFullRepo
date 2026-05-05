variable "project_name" {}
variable "environment" {}
variable "resource_group_name" {}
variable "location" {}
variable "public_subnet_id" {}
variable "vm_count" {
  type = number
}
variable "admin_username" {}
variable "ssh_public_key" {}
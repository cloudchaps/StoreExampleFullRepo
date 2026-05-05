variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "gcp_project_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}

variable "instance_count" {
  type    = number
  default = 3
}

variable "subnet_id" {
  type = string
}

variable "network_tags" {
  type    = list(string)
  default = ["web"]
}
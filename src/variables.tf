variable "admin_password" {
  default = "__admin_password__"
}

variable "admin_username" {
  default = "__admin_username__"
}

variable "application_insights_create" {
  default = "__application_insights_create__"
}

variable "application_insights_name" {
  default = "__application_insights_name__"
}

variable "container_registry_id" {
  default = "__container_registry_id__"
}

variable "key_vault_create" {
  default = "__key_vault_create__"
}

variable "key_vault_name" {
  default = "__key_vault_name__"
}

variable "key_vault_sku" {
  default = "__key_vault_sku__"
}

variable "kubernetes_cluster_create" {
  default = "__kubernetes_cluster_create__"
}

variable "kubernetes_cluster_name" {
  default = "__kubernetes_cluster_name__"
}

variable "kubernetes_subnet_name" {
  default = "__kubernetes_subnet_name__"
}

variable "kubernetes_version" {
  default = "__kubernetes_version__"
}

variable "location" {
  default = "__location__"
}

variable "log_analytics_workspace_id" {
  default = "__log_analytics_workspace_id__"
}

variable "machine_learning_create" {
  default = "__machine_learning_create__"
}

variable "machine_learning_friendly_name" {
  default = "__machine_learning_friendly_name__"
}

variable "machine_learning_name" {
  default = "__machine_learning_name__"
}

variable "machine_learning_sku" {
  default = "__machine_learning_sku__"
}

variable "machine_learning_subnet_name" {
  default = "__machine_learning_subnet_name__"
}

variable "resource_group_create" {
  default = "__resource_group_create__"
}

variable "resource_group_name" {
  default = "__resource_group_name__"
}

variable "ssh_key_data" {
  default = "__ssh_key_data__"
}

variable "storage_account_create" {
  default = "__storage_account_create__"
}

variable "storage_account_name" {
  default = "__storage_account_name__"
}

variable "virtual_network_create" {
  default = "__virtual_network_create__"
}

variable "virtual_network_name" {
  default = "__virtual_network_name__"
}

variable "virtual_network_resource_group_name" {
  default = "__virtual_network_resource_group_name__"
}

variable "virtual_network_subnet_names" {
  default = "__virtual_network_subnet_names__"
}

variable "tags" {
  default = {
    costCentre  = "IT Dev"
    createdBy   = "Terraform"
    environment = "__tags_environment__"
    location    = "__tags_location__"
    managedBy   = "__tags_managed_by__"
  }
}

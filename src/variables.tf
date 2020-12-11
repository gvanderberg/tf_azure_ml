variable "application_insights_create" {
  default = "__application_insights_create__"
}

variable "application_insights_name" {
  default = "__application_insights_name__"
}

variable "container_registry_create" {
  default = "__container_registry_create__"
}

variable "container_registry_name" {
  default = "__container_registry_name__"
}

variable "container_registry_sku" {
  default = "__container_registry_sku__"
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

variable "location" {
  default = "__location__"
}

variable "machine_learning_create" {
  default = "__machine_learning_create__"
}

variable "machine_learning_name" {
  default = "__machine_learning_name__"
}

variable "machine_learning_sku" {
  default = "__machine_learning_sku__"
}

variable "resource_group_create" {
  default = "__resource_group_create__"
}

variable "resource_group_name" {
  default = "__resource_group_name__"
}

variable "storage_account_create" {
  description = "Should the storage account be created."
  type        = bool
}

variable "storage_account_name" {
  description = "Specifies the name of the storage account."
  type        = string
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

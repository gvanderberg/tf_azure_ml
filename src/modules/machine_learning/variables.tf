variable "application_insights_id" {
  description = "The ID of the Application Insights associated with this machine learning workspace."
  type        = string
}

variable "container_registry_id" {
  description = "The ID of the container registry associated with this machine learning workspace."
  type        = string
}

variable "key_vault_id" {
  description = "The ID of key vault associated with this machine learning workspace."
  type        = string
}

variable "storage_account_id" {
  description = "The ID of the Storage Account associated with this machine learning workspace."
  type        = string
}

variable "machine_learning_create" {
  description = "Should the machine learning workspace be created."
  type        = bool
}

variable "machine_learning_friendly_name" {
  description = "Friendly name for this Machine Learning Workspace."
  type        = string
}

variable "machine_learning_name" {
  description = "Specifies the name of the machine learning workspace."
  type        = string
}

variable "machine_learning_sku" {
  description = "SKU/edition of the machine learning workspace, possible values are Basic for a basic workspace or Enterprise for a feature rich workspace."
  type        = string
}

variable "private_endpoint_name" {
  description = "Specifies the name of the private endpoint."
  type        = string
}

variable "resource_group_location" {
  description = "Specifies the supported Azure location where the machine learning workspace should exist."
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the name of the Resource Group in which the machine learning workspace should exist."
  type        = string
}

variable "virtual_network_name" {
  description = "Specifies the name of the Virtual Network this Subnet is located within."
  type        = string
}

variable "virtual_network_resource_group_name" {
  description = "Specifies the name of the resource group the Virtual Network is located in."
  type        = string
}

variable "virtual_network_subnet_name" {
  description = "Specifies the name of the Subnet."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(any)
}

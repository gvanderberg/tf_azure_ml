variable "key_vault_create" {
  description = "Should the key vault be created."
  type        = bool
}

variable "key_vault_name" {
  description = "Specifies the name of the key vault."
  type        = string
}

variable "key_vault_private_endpoint_name" {
  description = "Specifies the Name of the Private Endpoint."
  type        = string
}

variable "key_vault_sku" {
  description = "The Name of the SKU used for this key vault. Possible values are standard and premium."
  type        = string
}

variable "resource_group_location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the key vault."
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

variable "virtual_network_subnet_names" {
  description = "Specifies the name of the Subnet."
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(any)
}

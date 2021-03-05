variable "container_registry_create" {
  description = "Should the container registry be created."
  type        = bool
}

variable "container_registry_name" {
  description = "Specifies the name of the container registry."
  type        = string
}

variable "container_registry_sku" {
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium."
  type        = string
}

variable "resource_group_location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the container registry."
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

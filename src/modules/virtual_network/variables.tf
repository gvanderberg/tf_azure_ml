variable "resource_group_location" {
  description = "The location/region where the virtual network is created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}

variable "virtual_network_create" {
  description = "Should the virtual network be created."
  type        = bool
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(any)
}

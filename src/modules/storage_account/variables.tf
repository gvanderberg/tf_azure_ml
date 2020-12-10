variable "storage_account_create" {
  description = "Should the storage account be created."
  type        = bool
}

variable "storage_account_name" {
  description = "Specifies the name of the storage account."
  type        = string
}

variable "resource_group_location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(any)
}

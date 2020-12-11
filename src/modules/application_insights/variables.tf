variable "application_insights_create" {
  description = "Should the application insights component be created."
  type        = bool
}

variable "application_insights_name" {
  description = "Specifies the name of the application insights component."
  type        = string
}

variable "resource_group_location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the application insights component."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(any)
}

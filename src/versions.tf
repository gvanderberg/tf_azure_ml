terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>2"
    }
  }
  required_version = ">= 0.14"
}

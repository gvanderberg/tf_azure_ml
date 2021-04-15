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
    null = {
      source  = "hashicorp/null"
      version = "~>3"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3"
    }
  }
  required_version = ">= 0.14"
}

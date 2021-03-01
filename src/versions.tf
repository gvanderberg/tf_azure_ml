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
    helm = {
      source  = "hashicorp/helm"
      version = "~>2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>2"
    }
  }
  required_version = ">= 0.14"
}

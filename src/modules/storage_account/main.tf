data "azurerm_storage_account" "this" {
  count = var.storage_account_create ? 0 : 1

  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_storage_account" "this" {
  count = var.storage_account_create ? 1 : 0

  name                     = var.storage_account_name
  location                 = var.resource_group_location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags                     = var.tags
}

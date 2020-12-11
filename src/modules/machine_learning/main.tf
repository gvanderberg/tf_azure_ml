data "azurerm_machine_learning_workspace" "this" {
  count = var.machine_learning_create ? 0 : 1

  name                = var.machine_learning_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_machine_learning_workspace" "this" {
  count = var.machine_learning_create ? 1 : 0

  name                    = var.machine_learning_name
  location                = var.resource_group_location
  resource_group_name     = var.resource_group_name
  sku_name                = var.machine_learning_sku
  application_insights_id = var.application_insights_id
  container_registry_id   = var.container_registry_id
  key_vault_id            = var.key_vault_id
  storage_account_id      = var.storage_account_id

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

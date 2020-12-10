data "azurerm_client_config" "this" {}

data "azurerm_key_vault" "this" {
  count = var.key_vault_create ? 0 : 1

  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_key_vault" "this" {
  lifecycle {
    ignore_changes = [
      access_policy,
      network_acls["ip_rules"]
    ]
  }

  count = var.key_vault_create ? 1 : 0

  name                = var.key_vault_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku_name            = var.key_vault_sku
  tenant_id           = data.azurerm_client_config.this.tenant_id
  tags                = var.tags
}

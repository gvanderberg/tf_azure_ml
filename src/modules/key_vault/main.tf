data "azurerm_client_config" "this" {}

data "azurerm_subnet" "this" {
  count = var.key_vault_create ? 1 : 0

  name                 = var.virtual_network_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.virtual_network_resource_group_name
}

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

  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = [data.azurerm_subnet.this[count.index].id]
  }

  tags = var.tags
}

data "azurerm_client_config" "this" {}

data "azurerm_subnet" "this" {
  count = var.key_vault_create ? length(var.virtual_network_subnet_names) : 0

  name                 = var.virtual_network_subnet_names[count.index]
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.virtual_network_resource_group_name
}

data "azurerm_key_vault" "this" {
  count = var.key_vault_create ? 0 : 1

  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_key_vault" "this" {
  count = var.key_vault_create ? 1 : 0

  lifecycle {
    ignore_changes = [
      access_policy,
      network_acls["ip_rules"]
    ]
  }

  name                       = var.key_vault_name
  location                   = var.resource_group_location
  resource_group_name        = var.resource_group_name
  purge_protection_enabled   = true
  sku_name                   = var.key_vault_sku
  soft_delete_retention_days = 7
  tenant_id                  = data.azurerm_client_config.this.tenant_id

  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = data.azurerm_subnet.this.*.id
  }

  tags = var.tags
}

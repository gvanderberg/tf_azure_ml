locals {
  dns_zones    = ["privatelink.vaultcore.azure.net"]
  subresources = ["vault"]
}

data "azurerm_client_config" "this" {}

data "azurerm_subnet" "this" {
  count = var.key_vault_create ? length(var.virtual_network_subnet_names) : 0

  name                 = var.virtual_network_subnet_names[count.index]
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.virtual_network_resource_group_name
}

data "azurerm_virtual_network" "this" {
  count = var.key_vault_create ? 1 : 0

  name                = var.virtual_network_name
  resource_group_name = var.virtual_network_resource_group_name
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

resource "azurerm_private_dns_zone" "this" {
  count = var.key_vault_create ? length(local.dns_zones) : 0

  name                = local.dns_zones[count.index]
  resource_group_name = var.resource_group_name
}

resource "random_string" "this" {
  length  = 12
  special = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  count = var.key_vault_create ? length(azurerm_private_dns_zone.this) : 0

  name                  = random_string.this.result
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this[count.index].name
  virtual_network_id    = data.azurerm_virtual_network.this[0].id

  depends_on = [azurerm_private_dns_zone.this, data.azurerm_virtual_network.this, random_string.this]
}

resource "azurerm_private_endpoint" "this" {
  count = var.key_vault_create ? length(azurerm_private_dns_zone.this) : 0

  name                = format("%s-%s", var.key_vault_private_endpoint_name, local.subresources[count.index])
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.this[0].id

  private_service_connection {
    name                           = format("%s-%s", var.key_vault_private_endpoint_name, local.subresources[count.index])
    private_connection_resource_id = azurerm_key_vault.this[0].id
    subresource_names              = [local.subresources[count.index]]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.this[count.index].id]
  }

  depends_on = [azurerm_private_dns_zone.this, azurerm_key_vault.this, data.azurerm_subnet.this]
}

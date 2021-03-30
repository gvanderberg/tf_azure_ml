locals {
  dns_zones    = ["privatelink.blob.core.windows.net", "privatelink.file.core.windows.net"]
  subresources = ["blob", "file"]
}

data "azurerm_subnet" "this" {
  count = var.storage_account_create ? length(var.virtual_network_subnet_names) : 0

  name                 = var.virtual_network_subnet_names[count.index]
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.virtual_network_resource_group_name
}

data "azurerm_virtual_network" "this" {
  count = var.storage_account_create ? 1 : 0

  name                = var.virtual_network_name
  resource_group_name = var.virtual_network_resource_group_name
}

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
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_storage_account_network_rules" "this" {
  count = var.storage_account_create ? 1 : 0

  resource_group_name  = azurerm_storage_account.this[count.index].resource_group_name
  storage_account_name = azurerm_storage_account.this[count.index].name

  bypass                     = ["AzureServices"]
  default_action             = "Deny"
  ip_rules                   = []
  virtual_network_subnet_ids = data.azurerm_subnet.this.*.id

  depends_on = [azurerm_storage_account.this]
}

resource "azurerm_private_dns_zone" "this" {
  count = var.storage_account_create && var.private_endpoint_create ? length(local.dns_zones) : 0

  name                = local.dns_zones[count.index]
  resource_group_name = var.resource_group_name
}

resource "random_string" "this" {
  count = var.storage_account_create && var.private_endpoint_create ? 1 : 0

  length  = 12
  special = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  count = var.storage_account_create && var.private_endpoint_create ? length(azurerm_private_dns_zone.this) : 0

  name                  = random_string.this[0].result
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this[count.index].name
  virtual_network_id    = data.azurerm_virtual_network.this[0].id

  depends_on = [azurerm_private_dns_zone.this, data.azurerm_virtual_network.this, random_string.this]
}

resource "azurerm_private_endpoint" "this" {
  count = var.storage_account_create && var.private_endpoint_create ? length(azurerm_private_dns_zone.this) : 0

  name                = format("%s-%s", var.private_endpoint_name, local.subresources[count.index])
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.this[0].id

  private_service_connection {
    name                           = format("%s-%s", var.private_endpoint_name, local.subresources[count.index])
    private_connection_resource_id = azurerm_storage_account.this[0].id
    subresource_names              = [local.subresources[count.index]]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.this[count.index].id]
  }

  depends_on = [azurerm_private_dns_zone.this, azurerm_storage_account.this, data.azurerm_subnet.this]
}

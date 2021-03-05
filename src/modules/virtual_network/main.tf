locals {
  subnets = [
    {
      name    = "azsnet-bipp-lan",
      address = "10.51.24.0/25"
    },
    {
      name    = "azsnet-bipp-mlk8s",
      address = "10.51.26.0/24"
    }
  ]
}

data "azurerm_virtual_network" "this" {
  count = var.virtual_network_create ? 0 : 1

  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_resource_group" "this" {
  count = var.virtual_network_create ? 1 : 0

  name     = var.resource_group_name
  location = var.resource_group_location
  tags     = var.tags
}

resource "azurerm_virtual_network" "this" {
  count = var.virtual_network_create ? 1 : 0

  name                = var.virtual_network_name
  location            = azurerm_resource_group.this[0].location
  resource_group_name = azurerm_resource_group.this[0].name
  address_space       = ["10.51.24.0/22"]
  tags                = var.tags

  depends_on = [azurerm_resource_group.this]
}

resource "azurerm_subnet" "this" {
  count = var.virtual_network_create ? length(local.subnets) : 0

  name                 = local.subnets[count.index].name
  resource_group_name  = azurerm_resource_group.this[0].name
  address_prefixes     = [local.subnets[count.index].address]
  virtual_network_name = azurerm_virtual_network.this[0].name

  depends_on = [azurerm_virtual_network.this]
}

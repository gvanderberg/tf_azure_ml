data "azurerm_container_registry" "this" {
  count = var.container_registry_create ? 0 : 1

  name                = var.container_registry_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_container_registry" "this" {
  count = var.container_registry_create ? 1 : 0

  name                = var.container_registry_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  admin_enabled       = true

  network_rule_set {
    default_action = "Allow"
    # ip_rule {}
    # virtual_network {}
  }

  tags = var.tags
}

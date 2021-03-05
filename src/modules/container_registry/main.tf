data "azurerm_subnet" "this" {
  count = var.container_registry_create ? 1 : 0

  name                 = var.virtual_network_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.virtual_network_resource_group_name
}

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
  sku                 = var.container_registry_sku
  admin_enabled       = true

  # network_rule_set {
  #   default_action = "Allow"
  #   # ip_rule {}
  #   virtual_network {
  #     action    = "Allow"
  #     subnet_id = data.azurerm_subnet.this[count.index].id
  #   }
  # }

  tags = var.tags
}

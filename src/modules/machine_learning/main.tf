locals {
  dns_zones = ["privatelink.api.azureml.ms", "privatelink.notebooks.azure.net"]
}

data "azurerm_machine_learning_workspace" "this" {
  count = var.machine_learning_create ? 0 : 1

  name                = var.machine_learning_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "this" {
  count = var.machine_learning_create ? 1 : 0

  name                 = var.virtual_network_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.virtual_network_resource_group_name
}

data "azurerm_virtual_network" "this" {
  count = var.machine_learning_create ? 1 : 0

  name                = var.virtual_network_name
  resource_group_name = var.virtual_network_resource_group_name
}

resource "azurerm_machine_learning_workspace" "this" {
  count = var.machine_learning_create ? 1 : 0

  name                    = format("%s-%s", var.machine_learning_name, random_integer.postfix.result)
  location                = var.resource_group_location
  resource_group_name     = var.resource_group_name
  friendly_name           = var.machine_learning_friendly_name
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

resource "null_resource" "this" {
  count = var.machine_learning_create ? 1 : 0

  provisioner "local-exec" {
    command = "az ml computetarget create amlcompute --max-nodes 1 --min-nodes 0 --name cc-avengers --vm-size Standard_DS3_v2 --idle-seconds-before-scaledown 600 --assign-identity [system] --vnet-name ${var.virtual_network_name} --subnet-name ${var.virtual_network_subnet_name} --vnet-resourcegroup-name ${var.virtual_network_resource_group_name} --resource-group ${azurerm_machine_learning_workspace.this[count.index].resource_group_name} --workspace-name ${azurerm_machine_learning_workspace.this[count.index].name}"
  }

  depends_on = [azurerm_machine_learning_workspace.this]
}

resource "azurerm_private_dns_zone" "this" {
  count = var.machine_learning_create ? length(local.dns_zones) : 0

  name                = local.dns_zones[count.index]
  resource_group_name = var.virtual_network_resource_group_name
}

resource "random_string" "this" {
  length  = 12
  special = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  count = var.machine_learning_create ? length(azurerm_private_dns_zone.this) : 0

  name                  = random_string.this.result
  resource_group_name   = var.virtual_network_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this[count.index].name
  virtual_network_id    = data.azurerm_virtual_network.this[0].id

  depends_on = [azurerm_private_dns_zone.this, random_string.this]
}

resource "azurerm_private_endpoint" "this" {
  count = var.machine_learning_create ? 1 : 0

  name                = var.machine_learning_private_endpoint_name
  location            = azurerm_machine_learning_workspace.this[count.index].location
  resource_group_name = azurerm_machine_learning_workspace.this[count.index].resource_group_name
  subnet_id           = data.azurerm_subnet.this[0].id

  private_service_connection {
    name                           = var.machine_learning_private_endpoint_name
    private_connection_resource_id = azurerm_machine_learning_workspace.this[0].id
    subresource_names              = ["amlworkspace"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = azurerm_private_dns_zone.this.*.id
  }

  depends_on = [null_resource.this]
}

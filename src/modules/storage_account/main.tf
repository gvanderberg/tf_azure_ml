data "azurerm_subnet" "this" {
  count = var.storage_account_create ? length(var.virtual_network_subnet_names) : 0

  name                 = trimspace(var.virtual_network_subnet_names[count.index])
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.virtual_network_resource_group_name
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

  network_rules {
    bypass                     = ["AzureServices", "Logging", "Metrics"]
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = data.azurerm_subnet.this.*.id
  }

  tags = var.tags
}

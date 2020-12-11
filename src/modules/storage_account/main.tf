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
  account_replication_type = "GRS"
  min_tls_version          = "TLS1_2"

  identity {
    type = "SystemAssigned"
  }

  network_rules {
    default_action = "Allow"
    bypass         = ["AzureServices", "Logging", "Metrics"]
    # ip_rules                   = []
    # virtual_network_subnet_ids = []
  }

  tags = var.tags
}

data "azurerm_application_insights" "this" {
  count = var.application_insights_create ? 0 : 1

  name                = var.application_insights_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_application_insights" "this" {
  count = var.application_insights_create ? 1 : 0

  name                = var.application_insights_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  application_type    = "web"
  disable_ip_masking  = false
  retention_in_days   = 90
  tags                = var.tags
}

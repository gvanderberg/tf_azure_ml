data "azurerm_application_insights" "this" {
  count = var.application_insights_create ? 0 : 1

  name                = var.application_insights_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_application_insights" "this" {
  count = var.application_insights_create ? 1 : 0

  name                                  = var.application_insights_name
  resource_group_name                   = var.resource_group_name
  location                              = var.resource_group_location
  application_type                      = "web"
  disable_ip_masking                    = true
  daily_data_cap_in_gb                  = 0.1
  daily_data_cap_notifications_disabled = true
  retention_in_days                     = 30
  tags                                  = var.tags
}

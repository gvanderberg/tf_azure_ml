output "id" {
  value = element(coalescelist(azurerm_application_insights.this.*.id, data.azurerm_application_insights.this.*.id), 0)
}

output "instrumentation_key" {
  value = element(coalescelist(azurerm_application_insights.this.*.instrumentation_key, data.azurerm_application_insights.this.*.instrumentation_key), 0)
}

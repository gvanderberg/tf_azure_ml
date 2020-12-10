output "id" {
  value = element(coalescelist(azurerm_storage_account.this.*.id, data.azurerm_storage_account.this.*.id), 0)
}

output "primary_connection_string" {
  value = element(coalescelist(azurerm_resource_group.this.*.primary_connection_string, data.azurerm_resource_group.this.*.primary_connection_string), 0)
}

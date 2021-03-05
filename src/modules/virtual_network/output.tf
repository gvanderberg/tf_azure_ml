output "id" {
  value = element(coalescelist(azurerm_virtual_network.this.*.id, data.azurerm_virtual_network.this.*.id), 0)
}

output "name" {
  value = element(coalescelist(azurerm_virtual_network.this.*.name, data.azurerm_virtual_network.this.*.name), 0)
}

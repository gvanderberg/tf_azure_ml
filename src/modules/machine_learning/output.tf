output "id" {
  value = element(coalescelist(azurerm_machine_learning_workspace.this.*.id, data.azurerm_machine_learning_workspace.this.*.id), 0)
}

output "name" {
  value = element(coalescelist(azurerm_machine_learning_workspace.this.*.name, data.azurerm_machine_learning_workspace.this.*.name), 0)
}

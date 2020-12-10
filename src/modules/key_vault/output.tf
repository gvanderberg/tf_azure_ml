output "id" {
  value = element(coalescelist(azurerm_key_vault.this.*.id, data.azurerm_key_vault.this.*.id), 0)
}

output "vault_uri" {
  value = element(coalescelist(azurerm_key_vault.this.*.vault_uri, data.azurerm_key_vault.this.*.vault_uri), 0)
}

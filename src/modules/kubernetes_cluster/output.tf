output "client_key" {
  value = element(coalescelist(azurerm_kubernetes_cluster.this.*.kube_admin_config.0.client_key, [""]), 0)
}

output "client_certificate" {
  value = element(coalescelist(azurerm_kubernetes_cluster.this.*.kube_admin_config.0.client_certificate, [""]), 0)
}

output "cluster_ca_certificate" {
  value = element(coalescelist(azurerm_kubernetes_cluster.this.*.kube_admin_config.0.cluster_ca_certificate, [""]), 0)
}

output "cluster_username" {
  value = element(coalescelist(azurerm_kubernetes_cluster.this.*.kube_admin_config.0.username, [""]), 0)
}

output "cluster_password" {
  value = element(coalescelist(azurerm_kubernetes_cluster.this.*.kube_admin_config.0.password, [""]), 0)
}

output "kube_config" {
  value = element(coalescelist(azurerm_kubernetes_cluster.this.*.kube_admin_config_raw, [""]), 0)
}

output "host" {
  value = element(coalescelist(azurerm_kubernetes_cluster.this.*.kube_admin_config.0.host, [""]), 0)
}

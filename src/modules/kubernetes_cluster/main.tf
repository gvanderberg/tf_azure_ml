data "azuread_group" "this" {
  count = var.kubernetes_cluster_create ? 1 : 0

  display_name     = "K8S Administrators Security Group"
  security_enabled = true
}

data "azurerm_subnet" "this" {
  count = var.kubernetes_cluster_create ? 1 : 0

  name                 = var.virtual_network_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.virtual_network_resource_group_name
}

data "azurerm_virtual_network" "this" {
  count = var.kubernetes_cluster_create ? 1 : 0

  name                = var.virtual_network_name
  resource_group_name = var.virtual_network_resource_group_name
}

resource "azurerm_kubernetes_cluster" "this" {
  count = var.kubernetes_cluster_create ? 1 : 0

  lifecycle {
    ignore_changes = [
      api_server_authorized_ip_ranges
    ]
  }

  name                            = var.kubernetes_cluster_name
  resource_group_name             = var.resource_group_name
  location                        = var.resource_group_location
  api_server_authorized_ip_ranges = []
  dns_prefix                      = format("%s-%s", var.kubernetes_cluster_name, "dns")
  kubernetes_version              = var.kubernetes_version
  node_resource_group             = format("%s-%s", var.resource_group_name, "nodes")
  private_cluster_enabled         = false
  sku_tier                        = "Free"

  addon_profile {
    azure_policy {
      enabled = true
    }

    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = false
    }

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  default_node_pool {
    name                  = "agentpool"
    enable_auto_scaling   = var.enable_auto_scaling
    enable_node_public_ip = false
    availability_zones    = [1, 2, 3]
    max_pods              = "30"
    max_count             = var.enable_auto_scaling ? var.node_count + 2 : null
    min_count             = var.enable_auto_scaling ? var.node_count : null
    node_count            = var.node_count
    type                  = "VirtualMachineScaleSets"
    vm_size               = var.vm_size
    vnet_subnet_id        = data.azurerm_subnet.this[count.index].id
  }

  identity {
    type = "SystemAssigned"
  }

  linux_profile {
    admin_username = var.admin_username
    ssh_key {
      key_data = var.ssh_key_data
    }
  }

  windows_profile {
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    # dns_service_ip     = var.dns_service_ip
    # docker_bridge_cidr = var.docker_bridge_cidr
    load_balancer_sku = "standard"
    # service_cidr       = var.service_cidr
  }

  role_based_access_control {
    azure_active_directory {
      managed                = true
      admin_group_object_ids = [data.azuread_group.this[count.index].id]
    }
    enabled = true
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "aks" {
  count = var.kubernetes_cluster_create ? 1 : 0

  scope                = azurerm_kubernetes_cluster.this[count.index].id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azurerm_kubernetes_cluster.this[count.index].addon_profile[0].oms_agent[0].oms_agent_identity[0].object_id

  depends_on = [azurerm_kubernetes_cluster.this]
}

resource "azurerm_role_assignment" "net" {
  count = var.kubernetes_cluster_create ? 1 : 0

  scope                = data.azurerm_virtual_network.this[count.index].id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.this[count.index].identity[0].principal_id

  depends_on = [azurerm_kubernetes_cluster.this]
}

resource "azurerm_role_assignment" "acr" {
  count = var.kubernetes_cluster_create ? 1 : 0

  scope                = var.container_registry_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.this[count.index].kubelet_identity[0].object_id

  depends_on = [azurerm_kubernetes_cluster.this]
}

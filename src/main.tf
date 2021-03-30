terraform {
  backend "remote" {}
}

module "rg" {
  source = "./modules/resource_group"

  resource_group_create   = var.resource_group_create
  resource_group_name     = var.resource_group_name
  resource_group_location = var.location
  tags                    = var.tags
}

module "ai" {
  source = "./modules/application_insights"

  application_insights_create = var.application_insights_create
  application_insights_name   = var.application_insights_name
  resource_group_location     = module.rg.location
  resource_group_name         = module.rg.name
  tags                        = var.tags
}

module "ks" {
  source = "./modules/kubernetes_cluster"

  kubernetes_cluster_create              = var.kubernetes_cluster_create
  kubernetes_cluster_name                = var.kubernetes_cluster_name
  kubernetes_network_name                = var.virtual_network_name
  kubernetes_network_resource_group_name = var.virtual_network_resource_group_name
  kubernetes_network_subnet_name         = var.kubernetes_subnet_name
  kubernetes_version                     = var.kubernetes_version
  resource_group_location                = module.rg.location
  resource_group_name                    = module.rg.name
  admin_password                         = var.admin_password
  admin_username                         = var.admin_username
  container_registry_id                  = var.container_registry_id
  dns_service_ip                         = ""
  docker_bridge_cidr                     = ""
  enable_auto_scaling                    = false
  log_analytics_workspace_id             = var.log_analytics_workspace_id
  machine_learning_name                  = module.ml.name
  node_count                             = 3
  service_cidr                           = ""
  ssh_key_data                           = var.ssh_key_data
  vm_size                                = "Standard_B4ms"
  tags                                   = var.tags
}

module "kv" {
  source = "./modules/key_vault"

  key_vault_create                    = var.key_vault_create
  key_vault_name                      = var.key_vault_name
  key_vault_sku                       = var.key_vault_sku
  resource_group_location             = module.rg.location
  resource_group_name                 = module.rg.name
  private_endpoint_create             = var.private_endpoint_create
  private_endpoint_name               = var.private_endpoint_name
  virtual_network_name                = var.virtual_network_name
  virtual_network_resource_group_name = var.virtual_network_resource_group_name
  virtual_network_subnet_names        = [var.machine_learning_subnet_name, var.kubernetes_subnet_name]
  tags                                = var.tags
}

module "sa" {
  source = "./modules/storage_account"

  storage_account_create              = var.storage_account_create
  storage_account_name                = var.storage_account_name
  resource_group_location             = module.rg.location
  resource_group_name                 = module.rg.name
  private_endpoint_create             = var.private_endpoint_create
  private_endpoint_name               = var.private_endpoint_name
  virtual_network_name                = var.virtual_network_name
  virtual_network_resource_group_name = var.virtual_network_resource_group_name
  virtual_network_subnet_names        = [var.machine_learning_subnet_name, var.kubernetes_subnet_name]
  tags                                = var.tags
}

module "ml" {
  source = "./modules/machine_learning"

  machine_learning_create             = var.machine_learning_create
  machine_learning_name               = var.machine_learning_name
  machine_learning_friendly_name      = var.machine_learning_friendly_name
  machine_learning_sku                = var.machine_learning_sku
  resource_group_location             = module.rg.location
  resource_group_name                 = module.rg.name
  application_insights_id             = module.ai.id
  container_registry_id               = var.container_registry_id
  key_vault_id                        = module.kv.id
  private_endpoint_name               = var.private_endpoint_name
  storage_account_id                  = module.sa.id
  virtual_network_name                = var.virtual_network_name
  virtual_network_resource_group_name = var.virtual_network_resource_group_name
  virtual_network_subnet_name         = var.machine_learning_subnet_name
  tags                                = var.tags
}

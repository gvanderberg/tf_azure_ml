terraform {
  backend "local" {}
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

module "cr" {
  source = "./modules/container_registry"

  container_registry_create = var.container_registry_create
  container_registry_name   = var.container_registry_name
  container_registry_sku    = var.container_registry_sku
  resource_group_location   = module.rg.location
  resource_group_name       = module.rg.name
  tags                      = var.tags
}

module "kv" {
  source = "./modules/key_vault"

  key_vault_create        = var.key_vault_create
  key_vault_name          = var.key_vault_name
  key_vault_sku           = var.key_vault_sku
  resource_group_location = module.rg.location
  resource_group_name     = module.rg.name
  tags                    = var.tags
}

module "sa" {
  source = "./modules/storage_account"

  storage_account_create  = var.storage_account_create
  storage_account_name    = var.storage_account_name
  resource_group_location = module.rg.location
  resource_group_name     = module.rg.name
  tags                    = var.tags
}

module "ml" {
  source = "./modules/machine_learning"

  machine_learning_create = var.machine_learning_create
  machine_learning_name   = var.machine_learning_name
  machine_learning_sku    = var.machine_learning_sku
  resource_group_location = module.rg.location
  resource_group_name     = module.rg.name
  application_insights_id = module.ai.id
  container_registry_id   = module.cr.id
  key_vault_id            = module.kv.id
  storage_account_id      = module.sa.id
  tags                    = var.tags
}

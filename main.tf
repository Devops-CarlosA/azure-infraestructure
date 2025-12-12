locals {
  # Sanitizar nombre para storage account (solo minúsculas y números, max 24 chars)
  storage_name = lower(replace("tfsa${var.prefix}${var.environment}", "/[^a-z0-9]/", ""))

  # Tags comunes para todos los recursos
  common_tags = {
    environment = var.environment
    managed_by  = "terraform"
    project     = var.prefix
  }
}

module "resource_group" {
  source   = "git@github.com:Devops-CarlosA/terraform-module.git//azure/rsg?ref=main"
  name     = "rg-${var.prefix}-${var.environment}"
  location = var.location
  tags     = local.common_tags
}

module "storage_account" {
  source                   = "git@github.com:Devops-CarlosA/terraform-module.git//azure/storage?ref=main"
  name                     = local.storage_name
  resource_group_name      = module.resource_group.resource_group_name
  location                 = module.resource_group.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.common_tags
  #multiples container names
  container_names           = ["tf-infra-${var.environment}"]
  container_access_type    = "private"
}

module "acr" {
  source   = "git@github.com:Devops-CarlosA/terraform-module.git//azure/acr?ref=main"
  for_each = var.acrs

  name                    = each.value.name
  resource_group_name     = module.resource_group.resource_group_name
  location                = var.location
  sku                     = each.value.sku
  admin_enabled           = each.value.admin_enabled
  zone_redundancy_enabled = each.value.zone_redundancy_enabled
  tags                    = local.common_tags
}

module "nsg" {
  source               = "git@github.com:Devops-CarlosA/terraform-module.git//azure/nsg?ref=module-nsg"
  name                 = "nsg-${var.prefix}-${var.environment}"
  location             = var.location
  resource_group_name  = module.resource_group.resource_group_name
  tags                 = local.common_tags
}

module "network" {
  source               = "git@github.com:Devops-CarlosA/terraform-module.git//azure/network?ref=module-nsg"
  name                 = "vnet-${var.prefix}-${var.environment}"
  location             = var.location
  resource_group_name  = module.resource_group.resource_group_name
  address_space        = var.address_space
  dns_servers          = var.dns_servers
  tags                 = local.common_tags
}

module "subnets" {
  source               = "git@github.com:Devops-CarlosA/terraform-module.git//azure/network?ref=module-nsg"
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.network.virtual_network_name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = each.value.service_endpoints
  security_group       = module.nsg.network_security_group_id
}
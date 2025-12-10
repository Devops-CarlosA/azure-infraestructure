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
  container_name           = "tf-infra-${var.environment}"
  container_access_type    = "private"
}

module "acr" {
  source              = "git@github.com:Devops-CarlosA/terraform-module.git//azure/acr?ref=main"
  name                = "acr${var.prefix}${var.environment}"
  sku                 = "Premium"
  admin_enabled       = false
  location            = var.location
  zone_redundancy_enabled = true
  tags                = local.common_tags
}
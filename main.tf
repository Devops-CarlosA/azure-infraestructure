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
  source               = "git@github.com:Devops-CarlosA/terraform-module.git//azure/nsg?ref=main"
  name                 = "nsg-${var.prefix}-${var.environment}"
  location             = var.location
  resource_group_name  = module.resource_group.resource_group_name
  tags                 = local.common_tags
}

module "network" {
  source               = "git@github.com:Devops-CarlosA/terraform-module.git//azure/network?ref=main"
  name                 = "vnet-${var.prefix}-${var.environment}"
  location             = var.location
  resource_group_name  = module.resource_group.resource_group_name
  address_space        = var.address_space
  dns_servers          = var.dns_servers
  tags                 = local.common_tags
}

module "subnets" {
  source               = "git@github.com:Devops-CarlosA/terraform-module.git//azure/subnets?ref=main"
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.network.vnet_name
  address_prefixes     = each.value.address_prefixes
}

module "aks" {
  source              = "git@github.com:Devops-CarlosA/terraform-module.git//azure/aks?ref=main"
  name                = "aks-${var.prefix}-${var.environment}"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  dns_prefix          = "aks-${var.prefix}-${var.environment}"
  node_pool_name      = var.aks_node_pool_name
  node_count          = var.aks_node_count
  vm_size             = var.aks_vm_size
  vnet_subnet_id      = module.subnets[var.aks_subnet_name].subnet_id

  # Network configuration
  network_plugin      = var.aks_network_plugin
  network_policy      = var.aks_network_policy
  service_cidr        = var.aks_service_cidr
  dns_service_ip      = var.aks_dns_service_ip
  pod_cidr            = var.aks_pod_cidr

  tags                = local.common_tags
}

# ArgoCD installation
resource "null_resource" "install_argocd" {
  count      = var.install_argocd ? 1 : 0
  depends_on = [module.aks]

  provisioner "local-exec" {
    command = format(
      local.argocd_install_script_template,
      module.resource_group.resource_group_name,
      module.aks.cluster_name
    )
  }
  triggers = {
    cluster_id = module.aks.cluster_id
  }
}
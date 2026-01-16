#prefix=uat
environment = "staging"
location    = "southcentralus"
prefix      = "infra"

# DNS servers for the virtual network
dns_servers = ["10.0.0.4", "10.0.0.5"]
address_space = ["10.0.0.0/16"]

# Subnets configuration
subnets = {
  #"subnet-web" = {
  #  address_prefixes = ["10.0.1.0/24"]
  #}
  "subnet-aks" = {
    address_prefixes = ["10.0.2.0/23"]  # 512 IPs
  }
  #"subnet-app" = {
  #  address_prefixes = ["10.0.4.0/24"]
  #}
  #"subnet-db" = {
  #  address_prefixes = ["10.0.5.0/24"]
  #}
}

# Azure Container Registries
acrs = {
  #"staging" = {
  #  name                    = "acrstaginginfra"
  #  sku                     = "Basic"
  #  admin_enabled           = false
  #  zone_redundancy_enabled = true
  #}

  # acr for backups staging environment
  #"backups" = {
  #  name                    = "acrstagingbackupsinfra"
  #  sku                     = "Basic"
  #  admin_enabled           = false
  #  zone_redundancy_enabled = true
  #}
}

# AKS configuration
aks_node_count   = 2
aks_vm_size      = "Standard_B2s"  # Burstable, ideal para dev/test (~$30/mes vs $107/mes)
aks_subnet_name  = "subnet-aks"

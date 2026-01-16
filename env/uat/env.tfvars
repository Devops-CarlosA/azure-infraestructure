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
aks_node_pool_name = "agentpool"  # Node pool name (max 12 chars)
aks_node_count     = 2
aks_vm_size        = "Standard_B2s"
aks_subnet_name    = "subnet-aks"

# Cluster resources
install_argocd     = true  # Install ArgoCD automatically after cluster creation

# AKS Network configuration
aks_network_plugin  = "kubenet"        # kubenet (overlay) or azure (CNI)
aks_network_policy  = "calico"         # calico, azure, or null
aks_service_cidr    = "10.1.0.0/16"    # CIDR for Kubernetes services (must not overlap with VNet)
aks_dns_service_ip  = "10.1.0.10"      # Kubernetes DNS IP (must be within service_cidr)
aks_pod_cidr        = "10.244.0.0/16"  # CIDR for pods (kubenet only, must not overlap with VNet)

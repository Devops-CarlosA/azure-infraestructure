#prefix=uat
environment = "staging"
location    = "southcentralus"
prefix      = "infra"

# DNS servers for the virtual network
dns_servers = ["10.0.0.4", "10.0.0.5"]
address_space = ["10.0.0.0/16"]

# Azure Container Registries
acrs = {
  "staging" = {
    name                    = "acrstaginginfra"
    sku                     = "Basic"
    admin_enabled           = false
    zone_redundancy_enabled = true
  }

  # acr for backups staging environment
  #"backups" = {
  #  name                    = "acrstagingbackupsinfra"
  #  sku                     = "Basic"
  #  admin_enabled           = false
  #  zone_redundancy_enabled = true
  #}
}

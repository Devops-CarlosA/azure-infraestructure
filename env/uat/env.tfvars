#prefix=uat
environment = "staging"
location    = "southcentralus"
prefix      = "infra"

# Azure Container Registries
acrs = {
  "staging" = {
    name                    = "acrstaginginfra"
    sku                     = "Basic"
    admin_enabled           = false
    zone_redundancy_enabled = true
  }

  # acr for backups staging environment
  "backups" = {
    name                    = "acrstagingbackupsinfra"
    sku                     = "Basic"
    admin_enabled           = false
    zone_redundancy_enabled = true
  }
}

#prefix=uat
environment = "staging"
location    = "southcentralus"
prefix      = "infra"

# Azure Container Registries
acrs = {
  "staging" = {
    name                    = "acrstaginginfra"
    sku                     = "Premium"
    admin_enabled           = false
    zone_redundancy_enabled = true
  }
  "backups" = {
    name                    = "acrstagingbackupsinfra"
    sku                     = "Premium"
    admin_enabled           = false
    zone_redundancy_enabled = true
  }
}

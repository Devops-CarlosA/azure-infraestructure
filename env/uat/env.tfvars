#prefix=uat
environment = "staging"
location    = "southcentralus"
prefix      = "infra"

# Azure Container Registries
acrs = {
  "staging" = {
    name                    = "acr-staging-infra"
    sku                     = "Premium"
    admin_enabled           = false
    zone_redundancy_enabled = true
  }
  "backups" = {
    name                    = "acr-staging-backups-infra"
    sku                     = "Premium"
    admin_enabled           = false
    zone_redundancy_enabled = true
  }
}

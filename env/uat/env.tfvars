#prefix=uat
environment = "staging"
location    = "southcentralus"
prefix      = "infra"

# Azure Container Registries
acrs = {
  "staging" = {
    name                    = "acr-${prefix}-${environment}"
    sku                     = "Premium"
    admin_enabled           = false
    zone_redundancy_enabled = true
  }
  "backups" = {
    name                    = "acrinfra-backups-${prefix}-${environment}"
    sku                     = "Premium"
    admin_enabled           = false
    zone_redundancy_enabled = t
  }
}

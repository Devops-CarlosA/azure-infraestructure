#prefix=uat
environment = "staging"
location    = "southcentralus"
prefix      = "infra"

# Azure Container Registries
acrs = {
  "main" = {
    name                    = "acrinframainuat"
    sku                     = "Premium"
    admin_enabled           = false
    zone_redundancy_enabled = true
  }
}

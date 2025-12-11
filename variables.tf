variable "environment" {
  type        = string
  default     = "development"
  description = "The environment tag for the resources"
}

variable "prefix" {
  type        = string
  default     = "devops"
  description = "The prefix for naming resources"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "The Azure location where resources will be created"
}

variable "acrs" {
  description = "Map of ACR configurations"
  type = map(object({
    name                    = string
    sku                     = string
    admin_enabled           = bool
    zone_redundancy_enabled = bool
  }))
  default = {}
}
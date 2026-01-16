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

# variables network
variable "address_space" {
  type        = list(string)
  default     = []
  description = "The address space that is used by the virtual network"
}

variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "A list of DNS servers IP addresses"
}

variable "subnets" {
  description = "Map of subnet configurations"
  type = map(object({
    address_prefixes = list(string)
    service_endpoints = optional(list(string), [])
  }))
  default = {}
}

# AKS variables
variable "aks_node_count" {
  description = "Number of nodes in the default AKS node pool"
  type        = number
}

variable "aks_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
}

variable "aks_subnet_name" {
  description = "Name of the subnet to use for AKS nodes"
  type        = string
}
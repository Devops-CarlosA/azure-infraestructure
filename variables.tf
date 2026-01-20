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
variable "enable_aks" {
  description = "Enable or disable the AKS cluster creation"
  type        = bool
  default     = true
}

variable "aks_node_pool_name" {
  description = "Name of the default node pool (max 12 chars, lowercase, alphanumeric)"
  type        = string
}

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

variable "aks_kubernetes_version" {
  description = "Kubernetes version for the AKS cluster"
  type        = string
}

variable "install_argocd" {
  description = "Install ArgoCD on the AKS cluster after creation"
  type        = bool
  default     = false
}

# AKS Network configuration
variable "aks_network_plugin" {
  description = "Network plugin to use (azure or kubenet)"
  type        = string
  default     = "kubenet"
}

variable "aks_network_policy" {
  description = "Network policy to use (azure, calico, or null)"
  type        = string
  default     = null
}

variable "aks_service_cidr" {
  description = "CIDR for Kubernetes services"
  type        = string
  default     = "10.1.0.0/16"
}

variable "aks_dns_service_ip" {
  description = "IP address for Kubernetes DNS service"
  type        = string
  default     = "10.1.0.10"
}

variable "aks_pod_cidr" {
  description = "CIDR for pods (only for kubenet)"
  type        = string
  default     = "10.244.0.0/16"
}
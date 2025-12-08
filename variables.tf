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
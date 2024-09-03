#variable "client_id" {
#  description = "Azure Client ID"
#}
#
#variable "client_secret" {
#  description = "Azure Client Secret"
#  sensitive   = true
#}
#
#variable "subscription_id" {
#  description = "Azure Subscription ID"
#}
#
#variable "tenant_id" {
#  description = "Azure Tenant ID"
#}
# terraform/variables.tf

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "my-aci-resource-group"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
  default     = "mycontainerregistry"
}

variable "container_name" {
  description = "Name of the Azure Container Instance"
  type        = string
  default     = "my-azure-app"
}

variable "image_name" {
  description = "Docker image name with tag"
  type        = string
  default     = "my-azure-app:latest"
}

variable "cpu" {
  description = "Number of CPU cores for the container"
  type        = number
  default     = 1
}

variable "memory" {
  description = "Amount of memory (in GB) for the container"
  type        = number
  default     = 1.5
}

variable "dns_name_label" {
  description = "DNS name label for the container's public IP"
  type        = string
  default     = "my-azure-app-dns"
}

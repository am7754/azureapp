provider "azurerm" {
  features = {}
  # Service Principal Authentication
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}


# Reference to the existing resource group
data "azurerm_resource_group" "rg" {
  name     = "my_resource_group" # Replace with your resource group name
  location = "eastus"
}

# Create the storage account for Terraform state
resource "azurerm_storage_account" "storage" {
  name                      = "mystorageaccount" # Replace with your storage account name (must be globally unique)
  resource_group_name       = data.azurerm_resource_group.rg.name
  location                  = data.azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true

  lifecycle {
    prevent_destroy = true
  }
}

# Create the blob container for Terraform state
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

## Terraform Backend Configuration
#terraform {
#  backend "azurerm" {
#    resource_group_name  = "my_resource_group"
#    storage_account_name = "mystorageaccount"
#    container_name       = "tfstate"
#    key                  = "terraform.tfstate"
#  }
#}

# Reference to the existing Azure Container Registry
data "azurerm_container_registry" "acr" {
  name                = "ashfaqacrregistry" # Replace with your ACR name
  resource_group_name = data.azurerm_resource_group.rg.name
}
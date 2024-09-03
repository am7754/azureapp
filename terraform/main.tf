provider "azurerm" {
  features {}
}


# Reference to the existing resource group
data "azurerm_resource_group" "rg" {
  name = "my_resource_group" # Replace with your resource group name
}

# Create the storage account for Terraform state
#resource "azurerm_storage_account" "storage" {
#  name                     = "ashfaqstorageaccount" # Replace with your storage account name (must be globally unique)
#  resource_group_name      = data.azurerm_resource_group.rg.name
#  location                 = data.azurerm_resource_group.rg.location
#  account_tier             = "Standard"
#  account_replication_type = "LRS"
#
#  lifecycle {
#    prevent_destroy = true
#  }
#}

# Create the blob container for Terraform state
#resource "azurerm_storage_container" "tfstate" {
#  name                  = "tfstate2"
#  storage_account_name  = "ashfaqstorageaccount"
#  container_access_type = "private"
#}

# Terraform Backend Configuration
terraform {
  backend "azurerm" {
    resource_group_name  = "my_resource_group"
    storage_account_name = "ashfaqstorageaccount"
    container_name       = "tfstate2"
    key                  = "terraform.tfstate"
  }
}

# Reference to the existing Azure Container Registry
data "azurerm_container_registry" "acr" {
  name                = "ashfaqacrregistry" # Replace with your ACR name
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Reference the existing Azure Container Group (ACI)
data "azurerm_container_group" "myapp" {
  name                = "my-container-group"
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Grant ACR pull permissions to ACI
resource "azurerm_role_assignment" "acrpull" {
  principal_id         = "e79033e2-b474-4936-a1e9-3fe9283a7fe4"
  role_definition_name = "AcrPull"
  scope                = data.azurerm_container_registry.acr.id
}
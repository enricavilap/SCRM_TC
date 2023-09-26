###########################
## Azure Provider - Main ##
###########################

# Define Terraform provider
terraform {
  required_version = ">=1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

# Configure the Azure provider
provider "azurerm" {
  environment = "public"
  version     = "~>3.0"
  features {}
  subscription_id            = var.azure-subscription-id
  client_id                  = var.azure-client-id
  client_secret              = var.azure-client-secret
  tenant_id                  = var.azure-tenant-id
  skip_provider_registration = false

}



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


module "resource_group" {
  source   = "./modules/rg"
  location = var.location
  prefix   = var.prefix

}

module "postgree" {
  source                    = "./modules/postgree"
  resource_group_name       = module.resource_group.name
  location                  = var.location
  prefix                    = var.prefix
  postgresql-admin-login    = var.postgresql-admin-login
  postgresql-admin-password = var.postgresql-admin-password
}


module "virtual_machine" {
  source              = "./modules/vm"
  resource_group_name = module.resource_group.name
  location            = var.location
  prefix              = var.prefix
}

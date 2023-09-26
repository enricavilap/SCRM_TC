
########################################
# Resource Group - Main #
########################################

# Create a Resource Group for PostgreSQL
resource "azurerm_resource_group" "scrm-eavila-rg" {
  name     = "${var.prefix}-postgresql-rg"
  location = var.location
}


# Output the resource group attributes
output "location" {
  description = "The location of the Azure Resource Group"
  value       = azurerm_resource_group.scrm-eavila-rg.location
}

output "name" {
  description = "The name of the Azure Resource Group"
  value       = azurerm_resource_group.scrm-eavila-rg.name
}

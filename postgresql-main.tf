
########################################
# Azure Database for PostgreSQL - Main #
########################################


module "resource_group" {
  source   = "./rg"       # Path to the "rg" module directory
  location = var.location # Provide the actual location value
  prefix   = var.prefix   # Provide the actual prefix value
}

# Create a PostgreSQL Server
resource "azurerm_postgresql_server" "postgresql-server" {
  name                = "${var.prefix}-postgresql-server"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  administrator_login          = var.postgresql-admin-login
  administrator_login_password = var.postgresql-admin-password

  sku_name = var.postgresql-sku-name
  version  = var.postgresql-version

  storage_mb        = var.postgresql-storage
  auto_grow_enabled = true

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

# Create a PostgreSQL Database
resource "azurerm_postgresql_database" "postgresql-db" {
  name                = "scrm-db"
  resource_group_name = module.resource_group.name
  server_name         = azurerm_postgresql_server.postgresql-server.name
  charset             = "utf8"
  collation           = "English_United States.1252"
}

# Firewall Rule to access the PostgreSQL Server
resource "azurerm_postgresql_firewall_rule" "postgresql-fw-rule" {
  name                = "${var.prefix}-postgresql-allow-all"
  resource_group_name = module.resource_group.name
  server_name         = azurerm_postgresql_server.postgresql-server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "rg-shared-services"
}

# Virtual Network
resource "azurerm_virtual_network" "misfirm_network" {
  name                = "vnet-shared-10-65-0"
  address_space       = ["10.65.0.0/20"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet 1
resource "azurerm_subnet" "misfirm_subnet_1" {
  name                 = "snet-shared-10-60-0-0"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.misfirm_network.name
  address_prefixes     = ["10.65.0.0/24"]
}

# Subnet 2
resource "azurerm_subnet" "misfirm_subnet_2" {
  name                 = "snet-shared-10-60-1-0"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.misfirm_network.name
  address_prefixes     = ["10.65.1.0/24"]
}

# Gateway Subnet
resource "azurerm_subnet" "vnet_shared_gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.misfirm_network.name
  address_prefixes     = ["10.65.2.0/27"]
}
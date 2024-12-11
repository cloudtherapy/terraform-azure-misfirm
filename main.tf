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

resource "azurerm_local_network_gateway" "tierpoint" {
  name                = "lgw-shared-services-tierpoint"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  gateway_address     = "66.203.72.213"
  address_space       = ["10.227.0.0/16"]
}

resource "azurerm_public_ip" "vnet_shared_gateway_ip" {
  name                = "pip-shared-services-vgw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_virtual_network_gateway" "vnet_shared_gateway" {
  name                = "vgw-shared-services"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Standard"

  ip_configuration {
    name                          = "default"
    public_ip_address_id          = azurerm_public_ip.vnet_shared_gateway_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vnet_shared_gateway_subnet.id
  }
}

resource "azurerm_virtual_network_gateway_connection" "connection_tierpoint" {
  name                = "cn-shared-services-tierpoint"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vnet_shared_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.tierpoint.id

  shared_key = var.vpn_passphrase
}
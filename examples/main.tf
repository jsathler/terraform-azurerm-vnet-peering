locals {
  # hub_subscription_id    = ""
  # spoke_subscription_id = ""
}
provider "azurerm" {
  features {}
  #subscription_id = local.hub_subscription_id
}

provider "azurerm" {
  features {}
  #subscription_id = local.spoke_subscription_id
  alias = "spoke"
}

resource "azurerm_resource_group" "hub" {
  name     = "networking-hub-rg"
  location = "northeurope"
}

resource "azurerm_resource_group" "spoke" {
  name     = "networking-spoke-rg"
  location = "northeurope"
  provider = azurerm.spoke
}

resource "azurerm_virtual_network" "hub" {
  name                = "hub-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
}

resource "azurerm_virtual_network" "spoke" {
  name                = "spoke-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  provider            = azurerm.spoke
}

module "spoke-hub-peering" {
  source = "../"
  providers = {
    azurerm.local-vnet  = azurerm.spoke
    azurerm.remote-vnet = azurerm
  }

  local_vnet = {
    vnet_id             = azurerm_virtual_network.spoke.id
    use_remote_gateways = false
  }
  remote_vnet = {
    vnet_id               = azurerm_virtual_network.hub.id
    allow_gateway_transit = false
  }
}

output "spoke-hub-peering" {
  value = module.spoke-hub-peering
}

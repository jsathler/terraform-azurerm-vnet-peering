locals {
  split_local_vnet  = split("/", var.local_vnet.vnet_id)
  split_remote_vnet = split("/", var.remote_vnet.vnet_id)
}

resource "azurerm_virtual_network_peering" "local" {
  provider                     = azurerm.local-vnet
  name                         = var.local_vnet.peering_name != null ? "${var.local_vnet.peering_name}-vpeer" : "${element(local.split_remote_vnet, 8)}-vpeer"
  resource_group_name          = element(local.split_local_vnet, 4)
  virtual_network_name         = element(local.split_local_vnet, 8)
  remote_virtual_network_id    = var.remote_vnet.vnet_id
  allow_virtual_network_access = var.local_vnet.allow_virtual_network_access
  allow_forwarded_traffic      = var.local_vnet.allow_forwarded_traffic
  allow_gateway_transit        = var.local_vnet.allow_gateway_transit
  use_remote_gateways          = var.local_vnet.use_remote_gateways
}

resource "azurerm_virtual_network_peering" "remote" {
  provider                     = azurerm.remote-vnet
  name                         = var.remote_vnet.peering_name != null ? "${var.remote_vnet.peering_name}-vpeer" : "${element(local.split_local_vnet, 8)}-vpeer"
  resource_group_name          = element(local.split_remote_vnet, 4)
  virtual_network_name         = element(local.split_remote_vnet, 8)
  remote_virtual_network_id    = var.local_vnet.vnet_id
  allow_virtual_network_access = var.remote_vnet.allow_virtual_network_access
  allow_forwarded_traffic      = var.remote_vnet.allow_forwarded_traffic
  allow_gateway_transit        = var.remote_vnet.allow_gateway_transit
  use_remote_gateways          = var.remote_vnet.use_remote_gateways
}

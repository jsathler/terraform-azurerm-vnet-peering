module "devtest-hub-peering" {
  source = "jsathler/vnet-peering/azurerm"

  providers = {
    azurerm.local-vnet  = azurerm.devtest
    azurerm.remote-vnet = azurerm
  }

  local_vnet  = { vnet_id = module.devtest-vnet.vnet_id, use_remote_gateways = false }
  remote_vnet = { vnet_id = module.hub-vnet.vnet_id, allow_gateway_transit = false }
}

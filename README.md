# Azure Virtual Network Peering Terraform module

Terraform module which creates Azure Virtual Network Peering on Azure.

These types of resources are supported:

* [Virtual network peering](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview)

## Terraform versions

Terraform 1.5.6 and newer.

## Additional information

Since this module can create peering between two vnets in different subscriptions, you should provide the "providers" block as bellow.

If both vnets are in same subscription, use the same provider configuration for both "azurerm.local-vnet" and "azurerm.remote-vnet"

## Usage

```hcl
module "devtest-hub-peering" {
  source              = "jsathler/vnet-peering/azurerm"

  providers = {
    azurerm.local-vnet  = azurerm.devtest
    azurerm.remote-vnet = azurerm
  }

  local_vnet  = { vnet_id = module.devtest-vnet.vnet_id, use_remote_gateways = false }
  remote_vnet = { vnet_id = module.hub-vnet.vnet_id, allow_gateway_transit = false }
}
```

More samples in examples folder
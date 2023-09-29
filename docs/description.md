# Azure Virtual Network Peering Terraform module

Terraform module which creates Azure Virtual Network Peering on Azure.

Supported Azure services:

* [Virtual network peering](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview)

## Additional information

Since this module can create peering between two vnets in different subscriptions, you should provide the "providers" block as bellow.

If both vnets are in same subscription, use the same provider configuration for both "azurerm.local-vnet" and "azurerm.remote-vnet"
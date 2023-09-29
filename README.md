<!-- BEGIN_TF_DOCS -->
# Azure Virtual Network Peering Terraform module

Terraform module which creates Azure Virtual Network Peering on Azure.

Supported Azure services:

* [Virtual network peering](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview)

## Additional information

Since this module can create peering between two vnets in different subscriptions, you should provide the "providers" block as bellow.

If both vnets are in same subscription, use the same provider configuration for both "azurerm.local-vnet" and "azurerm.remote-vnet"

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm.local-vnet"></a> [azurerm.local-vnet](#provider\_azurerm.local-vnet) | >= 3.70.0 |
| <a name="provider_azurerm.remote-vnet"></a> [azurerm.remote-vnet](#provider\_azurerm.remote-vnet) | >= 3.70.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network_peering.local](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.remote](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_local_vnet"></a> [local\_vnet](#input\_local\_vnet) | Local vNet parameters. This parameter is required<br>   - vnet\_id:                       (required) The full Azure resource ID of the remote virtual network<br>   - peering\_name:                  (optional) If not defined, the vnet name will be used in the peering name<br>   - allow\_virtual\_network\_access:  (optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true<br>   - allow\_forwarded\_traffic:       (optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false<br>   - allow\_gateway\_transit:         (optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network. Defaults to false<br>   - use\_remote\_gateways:           (optional) Controls if remote gateways can be used on the local virtual network. Defaults to true | <pre>object({<br>    vnet_id                      = string<br>    peering_name                 = optional(string, null)<br>    allow_virtual_network_access = optional(bool, true)<br>    allow_forwarded_traffic      = optional(bool, false)<br>    allow_gateway_transit        = optional(bool, false)<br>    use_remote_gateways          = optional(bool, true)<br>  })</pre> | n/a | yes |
| <a name="input_remote_vnet"></a> [remote\_vnet](#input\_remote\_vnet) | Remote vNet parameters. This parameter is required<br>   - vnet\_id:                       (required) The full Azure resource ID of the remote virtual network<br>   - peering\_name:                  (optional) If not defined, the vnet name will be used in the peering name<br>   - allow\_virtual\_network\_access:  (optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true<br>   - allow\_forwarded\_traffic:       (optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false<br>   - allow\_gateway\_transit:         (optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network. Defaults to true<br>   - use\_remote\_gateways:           (optional) Controls if remote gateways can be used on the local virtual network. Defaults to false | <pre>object({<br>    vnet_id                      = string<br>    peering_name                 = optional(string, null)<br>    allow_virtual_network_access = optional(bool, true)<br>    allow_forwarded_traffic      = optional(bool, false)<br>    allow_gateway_transit        = optional(bool, true)<br>    use_remote_gateways          = optional(bool, false)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_local_peering_name"></a> [local\_peering\_name](#output\_local\_peering\_name) | Peering name on local vnet |
| <a name="output_remote_peering_name"></a> [remote\_peering\_name](#output\_remote\_peering\_name) | Peering name on remote vnet |

## Examples
```hcl
module "devtest-hub-peering" {
  source = "jsathler/vnet-peering/azurerm"

  providers = {
    azurerm.local-vnet  = azurerm.devtest
    azurerm.remote-vnet = azurerm
  }

  local_vnet  = { vnet_id = module.devtest-vnet.vnet_id, use_remote_gateways = false }
  remote_vnet = { vnet_id = module.hub-vnet.vnet_id, allow_gateway_transit = false }
}
```
More examples in ./examples folder
<!-- END_TF_DOCS -->
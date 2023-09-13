variable "local_vnet" {
  description = <<DESCRIPTION
  Local vNet parameters. This parameter is required
   - vnet_id:                       (required) The full Azure resource ID of the remote virtual network
   - peering_name:                  (optional) If not defined, the vnet name will be used in the peering name
   - allow_virtual_network_access:  (optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true
   - allow_forwarded_traffic:       (optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false
   - allow_gateway_transit:         (optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network. Defaults to false
   - use_remote_gateways:           (optional) Controls if remote gateways can be used on the local virtual network. Defaults to true
  DESCRIPTION
  type = object({
    vnet_id                      = string
    peering_name                 = optional(string, null)
    allow_virtual_network_access = optional(bool, true)
    allow_forwarded_traffic      = optional(bool, false)
    allow_gateway_transit        = optional(bool, false)
    use_remote_gateways          = optional(bool, true)
  })
  nullable = false
}

variable "remote_vnet" {
  description = <<DESCRIPTION
  Remote vNet parameters. This parameter is required
   - vnet_id:                       (required) The full Azure resource ID of the remote virtual network
   - peering_name:                  (optional) If not defined, the vnet name will be used in the peering name
   - allow_virtual_network_access:  (optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true
   - allow_forwarded_traffic:       (optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false
   - allow_gateway_transit:         (optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network. Defaults to true
   - use_remote_gateways:           (optional) Controls if remote gateways can be used on the local virtual network. Defaults to false
  DESCRIPTION
  type = object({
    vnet_id                      = string
    peering_name                 = optional(string, null)
    allow_virtual_network_access = optional(bool, true)
    allow_forwarded_traffic      = optional(bool, false)
    allow_gateway_transit        = optional(bool, true)
    use_remote_gateways          = optional(bool, false)
  })
  nullable = false
}

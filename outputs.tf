output "local_peering_name" {
  description = "Peering name on local vnet"
  value       = azurerm_virtual_network_peering.local.name
}

output "remote_peering_name" {
  description = "Peering name on remote vnet"
  value       = azurerm_virtual_network_peering.remote.name
}

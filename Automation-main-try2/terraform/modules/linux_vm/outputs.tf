
output "public_ip_address" {
  description = "The public IP address of the Linux Virtual Machine."
  value       = azurerm_public_ip.main.ip_address
}

output "public_ip_fqdn" {
  description = "The FQDN of the Linux Virtual Machine's public IP address."
  value       = azurerm_public_ip.main.fqdn
}

output "private_ip_address" {
  description = "The private IP address of the Linux Virtual Machine."
  value       = azurerm_network_interface.main.private_ip_address
}

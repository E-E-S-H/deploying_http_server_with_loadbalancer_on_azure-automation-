output "linux_vm_public_ips" {
  value = {
    for instance, vm in module.linux_vms : instance => vm.public_ip_address
  }
}
output "linux_vm_public_fqdns" {
  value = {
    for instance, vm in module.linux_vms : instance => vm.public_ip_fqdn
  }
}
output "linux_vm_private_ips" {
  value = {
    for instance, vm in module.linux_vms : instance => vm.private_ip_address
  }
}
output "load_balancer_public_ip" {
  value       = azurerm_public_ip.lb_public_ip.ip_address
}
output "load_balancer_fqdn" {
  value       = azurerm_public_ip.lb_public_ip.fqdn
}


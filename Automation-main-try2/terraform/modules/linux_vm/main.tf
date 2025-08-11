resource "azurerm_public_ip" "main" {
  name                = "n01731657-${var.instance_id}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}
resource "azurerm_network_interface" "main" {
  name                = "n01731657-${var.instance_id}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}
resource "azurerm_network_interface_backend_address_pool_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  ip_configuration_name     = "internal"
  backend_address_pool_id   = var.lb_backend_address_pool_id
}
resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = var.nsg_id
}
resource "azurerm_linux_virtual_machine" "main" {
  name                = "n01731657-${var.instance_id}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  availability_set_id = var.availability_set_id
  tags                = var.tags
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }
}
resource "azurerm_managed_disk" "data_disk" {
  for_each             = toset(["datadisk1", "datadisk2"])
  name                 = "n01731657-${var.instance_id}-${each.value}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
  tags                 = var.tags
}
resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attach" {
  for_each           = toset(["datadisk1", "datadisk2"])
  managed_disk_id    = azurerm_managed_disk.data_disk[each.value].id
  virtual_machine_id = azurerm_linux_virtual_machine.main.id
  lun                = each.value == "datadisk1" ? 10 : 11
  caching            = "ReadWrite"
}
resource "null_resource" "ansible_provisioning" {
  triggers = {
    vm_id = azurerm_linux_virtual_machine.main.id
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "Connecting to VM at ${azurerm_public_ip.main.ip_address} and running Ansible playbook..."
      ANSIBLE_ROLES_PATH=../ansible/roles ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook \
      -i "${azurerm_public_ip.main.ip_address}," \
      --private-key "${var.private_key_path}" \
      --user ${var.admin_username} \
      "../ansible/playbooks/n01731657-playbook.yml"
    EOT
  }

  depends_on = [
    azurerm_virtual_machine_data_disk_attachment.data_disk_attach,
  ]
}


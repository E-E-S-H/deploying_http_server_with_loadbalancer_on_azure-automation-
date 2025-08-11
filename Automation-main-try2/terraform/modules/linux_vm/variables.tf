variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region for the resources."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet."
  type        = string
}

variable "instance_id" {
  description = "The instance identifier for the VM (e.g., 'vm1')."
  type        = string
}

variable "vm_size" {
  description = "The size of the VM."
  type        = string
}

variable "availability_set_id" {
  description = "The ID of the availability set."
  type        = string
}

variable "nsg_id" {
  description = "The ID of the Network Security Group."
  type        = string
}

variable "admin_username" {
  description = "The admin username for the VM."
  type        = string
}

variable "public_key_path" {
  description = "The path to the public SSH key."
  type        = string
}

variable "private_key_path" {
  description = "The path to the private SSH key."
  type        = string
}

variable "lb_backend_address_pool_id" {
  description = "The ID of the Load Balancer backend address pool."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to all resources."
  type        = map(string)
}

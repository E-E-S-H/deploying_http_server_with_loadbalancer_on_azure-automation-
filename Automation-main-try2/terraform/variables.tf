variable "resource_group_name" {
  type        = string
  default     = "n01731657-rg"
}

variable "location" {
  type        = string
  default     = "Canada Central"
}

variable "vm_size" {
  description = "The size of the VM."
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "The username for the VMs."
  type        = string
  default     = "azueruser"
}

variable "public_key_path" {
  description = "The path to the public SSH key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "The path to the private SSH key"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "n01731657storage"
}

variable "tags" {
  description = "A map of tags to apply to the resources."
  type        = map(string)
  default     = {}
}

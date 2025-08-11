terraform {
  backend "azurerm" {
    resource_group_name  = "n01731657-automation-rg"
    storage_account_name = "tfstatenn01731657v1"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

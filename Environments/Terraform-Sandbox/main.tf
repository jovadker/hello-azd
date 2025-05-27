terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "ade-terraform-resource-group"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  name                     = "adeterraformsa${random_integer.suffix.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "random_integer" "suffix" {
  min = 10000
  max = 99999
  keepers = {
    resource_group = azurerm_resource_group.example.name
  }
}

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

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "ade_env_name" {
  description = "ADE environment name"
  type        = string
}

variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "ade_subscription" {
  description = "ADE subscription ID"
  type        = string
}

variable "ade_location" {
  description = "ADE environment location"
  type        = string
}

variable "ade_environment_type" {
  description = "ADE environment type"
  type        = string
}

/*resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.ade_location
}*/

resource "azurerm_storage_account" "example" {
  name                     = "adeterraformsa${random_integer.suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.ade_location
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

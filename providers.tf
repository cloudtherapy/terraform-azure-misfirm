terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id       = var.misfirm_client_id
  client_secret   = var.misfirm_client_secret
  tenant_id       = var.misfirm_tenant_id
  subscription_id = var.misfirm_subscription_id
}
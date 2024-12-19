terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.14.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "3.0.2"
    }
  }
}

provider "azuread" {
  client_id       = var.misfirm_client_id
  client_secret   = var.misfirm_client_secret
  tenant_id       = var.misfirm_tenant_id
}

provider "azurerm" {
  features {}
  client_id       = var.misfirm_client_id
  client_secret   = var.misfirm_client_secret
  tenant_id       = var.misfirm_tenant_id
  subscription_id = var.misfirm_subscription_id

  auxiliary_tenant_ids = ["klaughmanechostor.onmicrosoft.com"]
}

provider "azurerm" {
  alias = "msdn"
  features {}
  client_id       = var.msdn_client_id
  client_secret   = var.msdn_client_secret
  tenant_id       = var.msdn_tenant_id
  subscription_id = var.msdn_subscription_id

  auxiliary_tenant_ids = ["misfirm.com"]
}
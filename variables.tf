variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "misfirm_client_id" {
  type        = string
  sensitive   = true
  description = "Client ID of the Azure Application"
}

variable "misfirm_client_secret" {
  type        = string
  sensitive   = true
  description = "Client Secret of the Azure Application"
}

variable "misfirm_tenant_id" {
  type        = string
  sensitive   = true
  description = "Tenant ID of the Azure Application"
}

variable "misfirm_subscription_id" {
  type        = string
  sensitive   = true
  description = "Subscription ID of the Azure Application"
}
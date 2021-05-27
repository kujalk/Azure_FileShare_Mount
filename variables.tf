variable "SubscriptionID" {
  type        = string
  description = "Azure SubscriptionID"
}

variable "TenantID" {
  type        = string
  description = "Azure TenantID"
}

variable "resourcegroup" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure location"
}

variable "storage_account" {
  type        = string
  description = "Storage account name (must be unique)"
}

variable "fileshare" {
  type        = string
  description = "File share name"
}

variable "capacity" {
  type        = number
  description = "Capacity of fileshare in GB"
}

variable "drive" {
  type        = string
  description = "Local Drive Name"
}
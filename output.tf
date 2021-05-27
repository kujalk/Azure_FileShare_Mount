output "Storage-Key-1" {
  value = azurerm_storage_account.storage-account.primary_access_key
}

output "Storage-Key-2" {
  value = azurerm_storage_account.storage-account.secondary_access_key
}
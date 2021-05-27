/*
Developer - K.Janarthanan
Date - 28/5/2021
Purpose - Create Azure File Share and Auto mount to local drive
*/

data "template_file" "create-map" {
  template = file("Create_MapDrive.ps1")

  vars = {
    storage_key     = azurerm_storage_account.storage-account.primary_access_key
    storage_account = var.storage_account
    drive_name      = var.drive
    fileshare       = var.fileshare
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.resourcegroup
  location = var.location
}

resource "azurerm_storage_account" "storage-account" {
  name                     = var.storage_account
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "file-share" {
  name                 = var.fileshare
  storage_account_name = azurerm_storage_account.storage-account.name
  quota                = var.capacity

  acl {
    id = "MTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTI"

    access_policy {
      permissions = "rwdl"
    }
  }

  #Local provisioner for creating the network drive
  provisioner "local-exec" {
    command     = data.template_file.create-map.rendered
    interpreter = ["PowerShell", "-Command"]
  }
}

resource "null_resource" "delete-map" {
  triggers = {
    drive_name = var.drive
  }

  depends_on = [azurerm_storage_share.file-share]

  #Local provisoner for deleting the network drive
  provisioner "local-exec" {
    when        = destroy
    command     = "net use ${self.triggers.drive_name}: /delete /y"
    interpreter = ["PowerShell", "-Command"]
  }
}
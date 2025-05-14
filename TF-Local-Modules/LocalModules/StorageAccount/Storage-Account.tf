# Resource - 1 Storage Account

resource "azurerm_storage_account" "storage_account_module_new"{
    name = "${var.storage_account_name}${random_string.my_random.id}"
    resource_group_name = azurerm_resource_group.rg_2.name
    location = azurerm_resource_group.rg_2.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    account_kind = "StorageV2"
}

# Resource - 2 Storage account container
resource "azurerm_storage_container" "demo_files_module_container"{
    name = "filescontainer"
    storage_account_id = azurerm_storage_account.storage_account_module_new.id
    container_access_type = "private"
}

# Resource - 3 Static Website content inside SA
resource "azurerm_storage_account_static_website" "module_static_website"{
    index_document = "Website-index-document"
    error_404_document = "website-error-404-document"
    storage_account_id = azurerm_storage_account.storage_account_module_new.id
}



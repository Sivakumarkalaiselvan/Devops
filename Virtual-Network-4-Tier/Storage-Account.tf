# Resource - 1 Storage Account

resource "azurerm_storage_account" "storage_account_new"{
    name = "sivasks${random_string.my_random.id}"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    account_kind = "StorageV2"
}

# Resource - 2 Storage account container
resource "azurerm_storage_container" "demo_files_container"{
    name = "filescontainer"
    storage_account_id = azurerm_storage_account.storage_account_new.id
    container_access_type = "private"
}

# Resource - 3 Static Website content inside SA
resource "azurerm_storage_account_static_website" "static_website"{
    index_document = "Website-index-document"
    error_404_document = "website-error-404-document"
    storage_account_id = azurerm_storage_account.storage_account_new.id
}


# Locals Block    IF you are using multiple files in a folder and these to be uploaded on resources

locals{
    httpd_conf_files = ["app1.conf"]
}

# Resource - 4   Storage blob
resource "azurerm_storage_blob" "httpd_blob"{
    for_each = toset(local.httpd_conf_files)
    name = "${each.value}-blob"
    storage_account_name = azurerm_storage_account.storage_account_new.name
    storage_container_name = azurerm_storage_container.demo_files_container.name
    type = "Block"
    source = "${path.module}/app-scripts/${each.value}"
}
output "storage_account_id"{
    value = azurerm_storage_account.storage_account_new.id
}

output "storage_account_location"{
    value = azurerm_storage_account.storage_account_new.primary_location
}


output "storage_account_name"{
    value = azurerm_storage_account.storage_account_new.name
    }


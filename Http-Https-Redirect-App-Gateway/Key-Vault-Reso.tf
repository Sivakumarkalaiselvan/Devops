# Resource - 1 Data Source     It can be used to get the azurerm provider info's like subs id, tenant id
data "azurerm_client_config" "azureinfo" {}

# Resource - 2 Key Vault resource 
resource "azurerm_key_vault" "keyvault_demo"{
    name = "${var.Business_Division}${var.Environment_Variable}${random_resource.random_id}"
    location = azurerm_resource_group.rg_1.location
    resource_group_name = azurerm_resource_group.rg_1.name
    tenant_id = data.azurerm_client_config.azureinfo.tenant_id
    sku_name = "Premium"
    soft_delete_retention_days = 8
}

# Resource - 3 Key Vault Access Policy 
resource "azurerm_key_vault_access_policy" "demo_policy"{
    tenant_id = data.azurerm_client_config.azureinfo.tenant_id
    object_id = data.azurerm_client_config.azureinfo.object_id
    key_vault_id = azurerm_key_vault.keyvault_demo.id
    lifecycle{
        create_before_destroy = true       # It creates the keyvault before destroying the existing key-vault
    }
   certificate_permissions = ["Create", "Get", "List"]
   key_permissions = ["Create", "Get", "List"]
}
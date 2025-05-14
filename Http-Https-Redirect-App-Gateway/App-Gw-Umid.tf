# Umid - User Assigned Managed Identity for Keyvault & App Gateway
resource "azurerm_user_assigned_identity" "appgateway_uamid"{
    name = "${local.resource_name_prefix}-umaid"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
}



#Output Values
output "uamid"{
    description = "user assigned managed identity id"
    value = azurerm_user_assigned_identity.appgateway_uamid.id
}

output "uamiprincipalid"{
    description = "user assigned managed identity id"
    value = azurerm_user_assigned_identity.appgateway_uamid.principal_id
}

output "uamiclientid"{
    description = "user assigned managed identity id"
    value = azurerm_user_assigned_identity.appgateway_uamid.client_id
}


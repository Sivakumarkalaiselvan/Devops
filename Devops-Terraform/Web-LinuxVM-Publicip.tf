#Resource : Public IP Address for web linux vm
resource "azurerm_public_ip" "web_linuxvm_publicip"{
    name = "${local.resource_name_prefix}-web-linuxvm-publicip"
    location = azurerm_resource_group.rg_1.location
    resource_group_name = azurerm_resource_group.rg_1.name
    allocation_method = "Dynamic"
    sku = "Basic"
    domain_name_label = "app-linuxvm"
    tags = local.common_tags
}   
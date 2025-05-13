# Resource : Virtual Network
resource "azurerm_virtual_network" "vnet"{
    name = "${local.resource_name_prefix}-${var.vnet_name}"
    location=azurerm_resource_group.rg_1.location
    resource_group_name = azurerm_resource_group.rg_1.name
    address_space = var.vnet_address
    tags = local.common_tags
}
# TF Modules : Use it from public registry module

module "vnet" {
  source  = "Azure/vnet/azurerm"                 #From where we are using the module it's location
  version = "5.0.1"             # Optional 
  resource_group_name = azurerm_resource_group.rg_1
  vnet_name = "demo-vnet"
  vnet_location = azurerm_virtual_network.vnet.location
  address_space = ["10.0.0.0/16"]
  subnet_names = ["subnet1","subnet2","subnet3"]
  subnet_prefixes = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
  subnet_service_endpoints = {
    subnet2= ["Microsoft.sql"]
  }
}











/*# Resource : Virtual Network
resource "azurerm_virtual_network" "vnet"{
    name = "${local.resource_name_prefix}-${var.vnet_name}"
    location=azurerm_resource_group.rg_1.location
    resource_group_name = azurerm_resource_group.rg_1.name
    address_space = ["10.0.0.0/16"]
    tags = local.common_tags
}


# Resource Subnet 
resource "azurerm_subnet" "demo_subnet"{
    name = "demo_subnet"
    address_prefixes = ["10.0.1.0/24"]
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name = azurerm_resource_group.rg_1.name
} */
#Resource Group
resource "azurerm_resource_group" "vnet_rg"{
    name = "vnet-rg"
    location = "Australia Central"
}
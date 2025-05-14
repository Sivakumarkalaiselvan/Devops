# Resource : Network Interface for Web Linux VM
resource "azurerm_network_interface" "web_linuxvm_nic"{
    name = "${local.resource_name_prefix}-web-linuxvm-nic"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
    ip_configuration {                                     # Block Inside block (We can have multiple ip_config block)
      name = "weblinuxvm-ip"
      subnet_id = azurerm_subnet.web_subnet.id
      private_ip_address_allocation = "Dynamic"
     # public_ip_address_id = azurerm_public_ip.web_linuxvm_publicip.id
      #Primary = True                                      #If you're using multiple ip config block set one block as primary                                3
    }
}
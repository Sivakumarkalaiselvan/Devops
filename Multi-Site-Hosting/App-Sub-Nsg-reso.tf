# Resource 1  : App Tier Subnet
resource "azurerm_subnet" "app_subnet" {
  name = "${azurerm_virtual_network.vnet.name}-${var.app_subnet_name}"
  resource_group_name = azurerm_resource_group.rg_1.name
  address_prefixes = var.app_subnet_address
  virtual_network_name = azurerm_virtual_network.vnet.name
}

#Resource 2 : App Nsg
resource "azurerm_network_security_group" "app_nsg" {
    name = "${azurerm_subnet.app_subnet.name}-nsg"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
}

#Resource 3 : App Sub $ App Nsg Association
resource "azurerm_subnet_network_security_group_association" "app_sub_nsg_association" {
  depends_on = [azurerm_network_security_rule.app_nsg_inbound_rule]
  subnet_id = azurerm_subnet.app_subnet.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}


#Local blocks for network security rule
locals{
    app_inbound_security_port = {
        "100" : "22"
        "120" : "443"
    }
}

# Resource 4 : Network Security rule
resource "azurerm_network_security_rule" "app_nsg_inbound_rule"{
for_each = local.app_inbound_security_port
name                        = "rule-port-${each.key}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_1.name
  network_security_group_name = azurerm_network_security_group.web_nsg.name   # Associate the rules with nsg 
}

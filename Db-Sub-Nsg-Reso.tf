# Resource 1  : DB Tier Subnet
resource "azurerm_subnet" "db_subnet" {
  name = "${azurerm_virtual_network.vnet.name}-${var.db_subnet_name}"
  resource_group_name = azurerm_resource_group.rg_1.name
  address_prefixes = var.db_subnet_address
  virtual_network_name = azurerm_virtual_network.vnet.name
}

#Resource 2 : DB Nsg
resource "azurerm_network_security_group" "db_nsg" {
    name = "${azurerm_subnet.db_subnet.name}-nsg"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
}

#Resource 3 : DB Sub $ DB Nsg Association
resource "azurerm_subnet_network_security_group_association" "db_sub_nsg_association" {
  depends_on = [azurerm_network_security_rule.db_nsg_inbound_rule]
  subnet_id = azurerm_subnet.db_subnet.id
  network_security_group_id = azurerm_network_security_group.db_nsg.id
}


#Local blocks for network security rule
locals{
    db_inbound_security_port = {
        "100" : "22"
        "120" : "443"
    }
}

# Resource 4 : Network Security rule
resource "azurerm_network_security_rule" "db_nsg_inbound_rule"{
for_each = local.db_inbound_security_port
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
  network_security_group_name = azurerm_network_security_group.db_nsg.name   # Associate the rules with nsg 
}

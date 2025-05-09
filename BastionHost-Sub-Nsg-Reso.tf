# Resource 1  : Bastion Host Subnet
resource "azurerm_subnet" "bastion_host_subnet" {
  name = "${azurerm_virtual_network.vnet.name}-${var.bastion_host_subnet_name}"
  resource_group_name = azurerm_resource_group.rg_1.name
  address_prefixes = var.bastion_host_subnet_address
  virtual_network_name = azurerm_virtual_network.vnet.name
}

#Resource 2 : Bastion Host Nsg
resource "azurerm_network_security_group" "bastionhost_nsg" {
    name = "${azurerm_subnet.bastion_host_subnet.name}-nsg"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
}

#Resource 3 : Bastion Host Sub $ Bastion Host Nsg Association
resource "azurerm_subnet_network_security_group_association" "bastionhost_sub_nsg_association" {
  depends_on = [azurerm_network_security_rule.bastionhost_nsg_inbound_rule]
  subnet_id = azurerm_subnet.bastion_host_subnet.id
  network_security_group_id = azurerm_network_security_group.bastionhost_nsg.id
}


#Local blocks for network security rule
locals{
    bastionhost_inbound_security_port = {
        "100" : "3389"
        "120" : "443"
        "180" : "22"
    }
}

# Resource 4 : Network Security rule
resource "azurerm_network_security_rule" "bastionhost_nsg_inbound_rule"{
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
  network_security_group_name = azurerm_network_security_group.bastionhost_nsg.name   # Associate the rules with nsg 
}

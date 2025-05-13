# Resource : NSG for Web Linux VM
resource "azurerm_network_security_group" "web_nic_nsg"{
    name = "${local.resource_name_prefix}-weblinuxvm-nsg"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
}

# Resource : NIC & NSG Association
resource "azurerm_network_interface_security_group_association" "nic_webnsg_association"{
    depends_on =[azurerm_network_security_rule.web_nicvm_nsgrule]
    network_interface_id = azurerm_network_interface.web_linuxvm_nic.id
    network_security_group_id = azurerm_network_security_group.web_nic_nsg.id
}

#Resource : Local blocks for Network Security Rule
locals{
    web_nic_nsg_inbound_ports={
        "111": "22"
        "112" : "80"
    }
}

# Network Security Rule
resource "azurerm_network_security_rule" "web_nicvm_nsgrule"{
  for_each                    = local.web_nic_nsg_inbound_ports
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
  network_security_group_name = azurerm_network_security_group.web_nic_nsg.name   # Associate the rules with nsg 
}
# Resource 1 : Web Tier Subnet 
resource "azurerm_subnet" "web_subnet"{
    name = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name}"
    resource_group_name = azurerm_resource_group.rg_1.name
    address_prefixes= var.web_subnet_address
    virtual_network_name = azurerm_virtual_network.vnet.name
}
# Resource 2 : Web Network Security Group (NSG)                          # It supports i) IN-Line Rule & ii) External Rules
resource "azurerm_network_security_group" "web_nsg"{
    name = "${azurerm_subnet.web_subnet.name}-nsg"
    resource_group_name = azurerm_resource_group.rg_1.name
    location= azurerm_resource_group.rg_1.location
}
# Resource 3 : Subnet & Nsg Association
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
    depends_on = [azurerm_network_security_rule.web_nsg_rule_inbound]    #Nsg rule associate with nsg will disassociate the subnet & nsg . Azurerm provider bug. so we associate it only after the nsg is completely created.
    subnet_id = azurerm_subnet.web_subnet.id
    network_security_group_id = azurerm_network_security_group.web_nsg.id
}

# Resource 4 : NSG Rules

# local block for security rules (map)
locals{
    web_inbound_secuirty_ports_map ={
        "108":"22"                           # If the key value starts with number, you shoud use colon syntax :, insted of = 
        "140":"80"                           # each.key = 100        eaxh.value =22
        "180":"443"
    }
}

#Web Network Secuirty rules
resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  for_each                    = local.web_inbound_secuirty_ports_map  # For each iteration it is going to create each instance of that resource
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
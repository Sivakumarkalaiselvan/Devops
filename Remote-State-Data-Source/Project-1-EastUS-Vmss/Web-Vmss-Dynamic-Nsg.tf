# Nsg for VMSS using Dynamic Block 
resource "azurerm_network_security_group" "web_vmss_nsg"{
    name = "${local.resource_name_prefix}-web-vmss-nsg"
    location = azurerm_resource_group.rg_1.location
    resource_group_name = azurerm_resource_group.rg_1.name

dynamic "security_rule"{                                              # Dynamic Block Name - Security_rule
    for_each = var.web_linux_vmss_nsg_inbound_ports                       # Security_rule block is iterated with for_each
    # iterator = "demo"                                                     # Optional
content {                                                             # Arguments of security_rule block
   name                        = "rule-port-${security_rule.key}"          # Key is an index value of the list (0,1,2)
   priority                    = sum([100, security_rule.key])            # 100+0 = 100,   100+1 =101,    100+2= 102
   direction                   = "Inbound"
   access                      = "Allow"
   protocol                    = "Tcp"
   source_port_range           = "*"
   destination_port_range      = security_rule.value                      
   source_address_prefix       = "*"
   destination_address_prefix  = "*"
    }
}
}
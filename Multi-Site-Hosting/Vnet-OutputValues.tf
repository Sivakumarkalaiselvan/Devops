# Virtual Network Output values

#Virtual Network Name 
output "vnet_name"{
    description = "Print Virtual Network Name"
    value = azurerm_virtual_network.vnet.name        # argument reference  (Input for resources)
}

# Virtual Network ID 
output "vnet_id"{
    description = "Print Virtual network ID"
    value = azurerm_virtual_network.vnet.id          # Attribute refernce  (After the resource created)
}

# Web Subnet Name 
output "web_subnet_name" {
    description = "Print Subnet Name"
    value = azurerm_subnet.web_subnet.name
}

# Web Subnet ID 
output "Web_subnet_id"{
    description="Print Subnet ID"
    value = azurerm_subnet.web_subnet.id
}

# Web Network Security group Name 
output "web_nsg_name" {
    description = "Print nsg name"
    value = azurerm_network_security_group.web_nsg.name
}
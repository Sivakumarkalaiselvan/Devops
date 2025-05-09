# Output values for pub ip
/*output "public_ip_linuxvm" {
  description = "Public ip of linuxvm"
  value = azurerm_public_ip.web_linuxvm_publicip.ip_address
} */

# Network interface id
output "nic_webvm"{
    description = "NIC id for webvm"
    value = azurerm_network_interface.web_linuxvm_nic.id
}

#Private ip address of nic (list only 1st ip of nic)
output "pvt_ip_nic"{
    description = "Private Ip of Network interface"
    value =azurerm_network_interface.web_linuxvm_nic.private_ip_address
}

#Private ip address of nic (list multiple pvt ip's of nic)
output "pvt_ip_nics"{
    description = "Private Ip of Network interface"
    value = [azurerm_network_interface.web_linuxvm_nic.private_ip_addresses]        #List of pvt ip add
}


#Virtual Machine 128 bit id
output "vm_128bit_id"{ 
    description = "Linux vm 128 bit id"
    value = azurerm_linux_virtual_machine.web_linuxvm.virtual_machine_id
}

#Virtual Machine id
output "vm_id"{ 
    description = "Linux vm id"
    value = azurerm_linux_virtual_machine.web_linuxvm.id
}
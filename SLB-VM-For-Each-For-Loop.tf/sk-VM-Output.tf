# Dif outputs with Terraform for loop

# Output List - Single Input to for loop
output "sk_linuxvm_list_pvt_ip"{
    description = "private ip address of instances"                # When you're using meta argument (count or for_each) can't able to reference the object directly it will not work
    value = [for sk in azurerm_linux_virtual_machine.skvm_linux : sk.private_ip_address]
}


# Output Map - Single Input to for loop
output "sk_linuxvm_map_pvt_ip" {
    description = "pvt ip address of the instances"
    value = {for sk in azurerm_linux_virtual_machine.skvm_linux : sk.name => sk.private_ip_addresses}
}

# Terraform keys () - Returns the list of keys from the map
output "sk_linuxvm_map_keys_pvt_ip"{
    description = "Returns the list of keys from the map"
    value = keys({for sk in azurerm_linux_virtual_machine.skvm_linux : sk.name => sk.private_ip_addresses})
}


# Terrafrom values () - Returns the list of values from the map
output "sk_linuxvm_map_values_pvt_ip"{
    description = "Returns the list of values from the map"
    value = values({for sk in azurerm_linux_virtual_machine.skvm_linux : sk.name => sk.private_ip_addresses})
}



# Output List - Two inputs to the for loop
output "sk_linuxvm_list2_pvt_ip"{
    description = "private ip address of instances"                
    value = [for i, sk in azurerm_linux_virtual_machine.skvm_linux : sk.private_ip_address]
}

# Output Map - Two inputs to the for loop 
output "sk_linuxvm_map2_pvt_ip" {
    description = "pvt ip address of the instances"
    value = {for i, sk in azurerm_linux_virtual_machine.skvm_linux : i => sk.private_ip_addresses}
}
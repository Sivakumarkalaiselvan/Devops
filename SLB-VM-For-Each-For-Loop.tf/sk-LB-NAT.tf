# Resource - Nat rule for vm's
resource "azurerm_lb_nat_rule" "sk_lb_nat_rule"{
    depends_on = [ azurerm_linux_virtual_machine.skvm_linux ]     #To handle the azurerm provider related bugs when destroying the reso
    for_each = var.sk_vm_instance_count
    name = "${each.key}-nat-rule-${each.value}"
    protocol = "Tcp"
    #frontend_port = each.value
    frontend_port = lookup(var.sk_vm_instance_count, each.key, 600)     #Lookup(map, key, default)
    backend_port = "22"
    frontend_ip_configuration_name = azurerm_lb.sk_lb.frontend_ip_configuration[0].name
    resource_group_name = azurerm_resource_group.vnet_rg_2.name
    loadbalancer_id = azurerm_lb.sk_lb.id
}


# Resource Nic & Nat rule association 
resource "azurerm_network_interface_nat_rule_association" "sk_nic_nat_rule_association"{
    for_each = var.sk_vm_instance_count
    network_interface_id = azurerm_network_interface.nic_2[each.key].id
    ip_configuration_name = azurerm_network_interface.nic_2[each.key].ip_configuration[0].name
    nat_rule_id =azurerm_lb_nat_rule.sk_lb_nat_rule[each.key].id
}
# Resource - Nat rule for vm's
resource "azurerm_lb_nat_rule" "siva_lb_nat_rule"{
    depends_on = [ azurerm_linux_virtual_machine.sivavm_linux ]     #To handle the azurerm provider related bugs when destroying the reso
    count = var.siva_vm_instance_count
    name = "Siva-nat-rule-${var.sivavm_inbound_nat_rules[count.index]}"
    protocol = "Tcp"
    frontend_port = element(var.sivavm_inbound_nat_rules, count.index)
    backend_port = "22"
    frontend_ip_configuration_name = azurerm_lb.siva_lb.frontend_ip_configuration[0].name
    resource_group_name = azurerm_resource_group.vnet_rg.name
    loadbalancer_id = azurerm_lb.siva_lb.id
}


# Resource Nic & Nat rule association 
resource "azurerm_network_interface_nat_rule_association" "nic_nat_rule_association"{
    count = var.siva_vm_instance_count
    network_interface_id = element(azurerm_network_interface.nic[*].id, count.index)
    ip_configuration_name = element(azurerm_network_interface.nic[*].ip_configuration[0].name, count.index)
    nat_rule_id =element(azurerm_lb_nat_rule.siva_lb_nat_rule[*].id, count.index)
}
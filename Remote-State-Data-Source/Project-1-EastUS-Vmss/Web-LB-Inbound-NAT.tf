# Resource - Inbound NAT Rule
resource "azurerm_lb_nat_rule" "web_lb_inbound_nat_rule"{
    name = "fp-1033-ssh-22"
    protocol = "Tcp"
    frontend_port = 1033
    backend_port = 22
    frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
    loadbalancer_id = azurerm_lb.web_lb.id
    resource_group_name = azurerm_resource_group.rg_1.name
}


/*#Resource - NIC & NAT Rule Association
resource "azurerm_network_interface_nat_rule_association"  "web_lb_nic_nat_ass"{
    network_interface_id = azurerm_network_interface.web_linuxvm_nic.id
    ip_configuration_name = azurerm_network_interface.web_linuxvm_nic.ip_configuration[0].name
    nat_rule_id = azurerm_lb_nat_rule.web_lb_inbound_nat_rule.id
} */



resource "azurerm_lb_nat_pool" "web_vmss_nat" {                  # If you want to associate the lb NAT to VMSS use NAT Pool resource
  depends_on = [azurerm_lb_nat_rule.web_lb_inbound_nat_rule]
  resource_group_name            = azurerm_resource_group.rg_1.name
  loadbalancer_id                = azurerm_lb.web_lb.id
  name                           = "Web-vmss-nat-rule"
  protocol                       = "Tcp"
  frontend_port_start            = 5000
  frontend_port_end              = 5003
  backend_port                   = 22
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
}
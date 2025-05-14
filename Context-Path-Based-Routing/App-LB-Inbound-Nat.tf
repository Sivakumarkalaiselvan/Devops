resource "azurerm_lb_nat_pool" "app_vmss_nat" {                  # If you want to associate the lb NAT to VMSS use NAT Pool resource
  resource_group_name            = azurerm_resource_group.rg_1.name
  loadbalancer_id                = azurerm_lb.app_lb.id
  name                           = "app-vmss-nat-rule"
  protocol                       = "Tcp"
  frontend_port_start            = 9000
  frontend_port_end              = 9003
  backend_port                   = 22
  frontend_ip_configuration_name = azurerm_lb.app_lb.frontend_ip_configuration[0].name 
}
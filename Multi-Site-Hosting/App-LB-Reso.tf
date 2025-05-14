
# Resource - Standard Load Balancer
resource "azurerm_lb" "app_lb"{
    name = "${local.resource_name_prefix}-app-lb"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
    sku = "Standard"
    frontend_ip_configuration {
      name = "app-fpip-1"
      subnet_id = azurerm_subnet.app_subnet.id
      private_ip_address_allocation = "Static"
      private_ip_address_version = "IPv4"
      private_ip_address = "10.0.5.10"
    }
}

# Resource - Backend address pool
resource "azurerm_lb_backend_address_pool" "app_backend_pool"{
    name = "app-backend-pool"
    loadbalancer_id = azurerm_lb.app_lb.id
}

# Resource - LB probe
resource "azurerm_lb_probe" "app_lb_probe"{
    name = "app-lb-probe"
    protocol = "Tcp"
    port = 80
    loadbalancer_id = azurerm_lb.app_lb.id
    
}

# Resource - LB Rule 
resource "azurerm_lb_rule" "app_lb_rule_1"{
    name = "app-lb-rule-1"
    protocol = "Tcp"
    frontend_port = 80
    backend_port = 80
    frontend_ip_configuration_name = azurerm_lb.app_lb.frontend_ip_configuration[0].name    # List of ip address
    backend_address_pool_ids = [azurerm_lb_backend_address_pool.app_backend_pool.id]
    probe_id = azurerm_lb_probe.app_lb_probe.id
    loadbalancer_id = azurerm_lb.app_lb.id
}
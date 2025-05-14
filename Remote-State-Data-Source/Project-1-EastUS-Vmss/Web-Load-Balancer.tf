# Resource - Public IP for azure Load Balancer
resource "azurerm_public_ip" "web_lb_pub_ip"{
    name = "${local.resource_name_prefix}-web-pub-ip"
    resource_group_name= azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
    allocation_method = "Static"
    sku = "Standard"
    domain_name_label = "proj-1eastus"
    }

# Resource - Standard Load Balancer
resource "azurerm_lb" "web_lb"{
    name = "${local.resource_name_prefix}-web-lb"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
    sku = "Standard"
    frontend_ip_configuration {
      name = "web-fpip-1"
      public_ip_address_id = azurerm_public_ip.web_lb_pub_ip.id
    }
}

# Resource - Backend address pool
resource "azurerm_lb_backend_address_pool" "web_backend_pool"{
    name = "web-backend-pool"
    loadbalancer_id = azurerm_lb.web_lb.id
}

# Resource - LB probe
resource "azurerm_lb_probe" "web_lb_probe"{
    name = "web-lb-probe"
    protocol = "Tcp"
    port = 80
    loadbalancer_id = azurerm_lb.web_lb.id
    
}

# Resource - LB Rule 
resource "azurerm_lb_rule" "web_lb_rule_1"{
    name = "web-lb-rule-1"
    protocol = "Tcp"
    frontend_port = 80
    backend_port = 80
    frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name    # List of ip address
    backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_backend_pool.id]
    probe_id = azurerm_lb_probe.web_lb_probe.id
    loadbalancer_id = azurerm_lb.web_lb.id
}

/*# Resource - NIC & Backend pool Association
resource "azurerm_network_interface_backend_address_pool_association" "lb_nic_backend_pool_association"{
    network_interface_id = azurerm_network_interface.web_linuxvm_nic.id
    ip_configuration_name = azurerm_network_interface.web_linuxvm_nic.ip_configuration[0].name    #List of ip's under nic 
    backend_address_pool_id = azurerm_lb_backend_address_pool.web_backend_pool.id
}   */
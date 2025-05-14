# Public ip for Load Balancer
resource "azurerm_public_ip" "siva_lb_pub_ip"{
    name = "siva-lb-pub-ip"
    resource_group_name = azurerm_resource_group.vnet_rg.name
    location = azurerm_resource_group.vnet_rg.location
    allocation_method = "Static"
    sku = "Standard"
}

# Azure Load Balancer
resource "azurerm_lb" "siva_lb"{
    name = "siva-lb"
    resource_group_name = azurerm_resource_group.vnet_rg.name
    location = azurerm_resource_group.vnet_rg.location
    sku = "Standard"
    frontend_ip_configuration {
      name = "frnt-siva-pip"
      public_ip_address_id = azurerm_public_ip.siva_lb_pub_ip.id
    }
}

# Azure backend address pool
resource "azurerm_lb_backend_address_pool" "siva_lb_backemnd_address_pool"{
    name = "Siva-lb-backend-add-pool"
    loadbalancer_id = azurerm_lb.siva_lb.id
}
# Load Balancer Health probe
resource "azurerm_lb_probe" "siva_lb_probe"{
    name = "Siva-lb-probe"
    protocol = "Tcp"
    port = 80
    loadbalancer_id = azurerm_lb.siva_lb.id
}

# Load balancing rule 
resource "azurerm_lb_rule" "siva_lb_rule"{
    name = "siva-lb-rule"
    protocol = "Tcp"
    frontend_port = 80
    backend_port = 80
    frontend_ip_configuration_name = azurerm_lb.siva_lb.frontend_ip_configuration[0].name
    probe_id = azurerm_lb_probe.siva_lb_probe.id
    loadbalancer_id = azurerm_lb.siva_lb.id
}
# NIC & backend add pool Association
resource "azurerm_network_interface_backend_address_pool_association" "nic_backend_pool_association"{
    count = var.siva_vm_instance_count
    network_interface_id = element(azurerm_network_interface.nic[*].id, count.index)      # Splat Exp
    ip_configuration_name = element(azurerm_network_interface.nic[*].ip_configuration[0].name, count.index)    
    backend_address_pool_id = azurerm_lb_backend_address_pool.siva_lb_backemnd_address_pool.id
}
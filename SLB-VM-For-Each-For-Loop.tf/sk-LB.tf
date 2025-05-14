# Public ip for Load Balancer
resource "azurerm_public_ip" "sk_lb_pub_ip"{
    name = "sk-lb-pub-ip"
    resource_group_name = azurerm_resource_group.vnet_rg_2.name
    location = azurerm_resource_group.vnet_rg_2.location
    allocation_method = "Static"
    sku = "Standard"
}

# Azure Load Balancer
resource "azurerm_lb" "sk_lb"{
    name = "sk-lb"
    resource_group_name = azurerm_resource_group.vnet_rg_2.name
    location = azurerm_resource_group.vnet_rg_2.location
    sku = "Standard"
    frontend_ip_configuration {
      name = "frnt-sk-pip"
      public_ip_address_id = azurerm_public_ip.sk_lb_pub_ip.id
    }
}

# Azure backend address pool
resource "azurerm_lb_backend_address_pool" "sk_lb_backend_address_pool"{
    name = "Sk-lb-backend-add-pool"
    loadbalancer_id = azurerm_lb.sk_lb.id
}
# Load Balancer Health probe
resource "azurerm_lb_probe" "sk_lb_probe"{
    name = "Sk-lb-probe"
    protocol = "Tcp"
    port = 80
    loadbalancer_id = azurerm_lb.sk_lb.id
}

# Load balancing rule 
resource "azurerm_lb_rule" "sk_lb_rule"{
    name = "sk-lb-rule"
    protocol = "Tcp"
    frontend_port = 80
    backend_port = 80
    frontend_ip_configuration_name = azurerm_lb.sk_lb.frontend_ip_configuration[0].name
    probe_id = azurerm_lb_probe.sk_lb_probe.id
    loadbalancer_id = azurerm_lb.sk_lb.id
}
# NIC & backend add pool Association
resource "azurerm_network_interface_backend_address_pool_association" "sk_nic_backend_pool_association"{
    for_each = var.sk_vm_instance_count
    network_interface_id = azurerm_network_interface.nic_2[each.key].id     
    ip_configuration_name = azurerm_network_interface.nic_2[each.key].ip_configuration[0].name    
    backend_address_pool_id = azurerm_lb_backend_address_pool.sk_lb_backend_address_pool.id
}
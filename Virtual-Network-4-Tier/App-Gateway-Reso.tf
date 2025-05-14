# Resource - 1 : public ip for frontend application gateway
resource "azurerm_public_ip" "app_gat_public_ip"{
    name = "${local.resource_name_prefix}-app-pub-ip"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
    allocation_method = "Dynamic"
    sku = "Basic"
}

# Locals block for Application gateway
locals{
    #Generic
    frontend_port_name = "${azurerm_virtual_network.vnet.name}-fport"
    frontend_ip_configuration_name="${azurerm_virtual_network.vnet.name}-fipconf"
    listener_name ="${azurerm_virtual_network.vnet.name}-listener1"
    request_routing_rule1_name = "${azurerm_virtual_network.vnet.name}-req-rule1"

    # Application 1
    backend_address_pool_name = "${azurerm_virtual_network.vnet.name}-backend-add-pool1"
    http_setting_name_app1 = "${azurerm_virtual_network.vnet.name}-http-setting-app1"
    probe_name_app1 =  "${azurerm_virtual_network.vnet.name}-probe-app1"
}


# Resource - 2 : Application Gateway
resource "azurerm_application_gateway" "application_gateway"{
    name = "${local.resource_name_prefix}-app-gateway"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location

    # Start of sku 
    sku{
        name = "standard_medium"
        tier = "Standard_v2"
        # Capacity = 2             It defines auto scaling
    }
    autoscale_configuration {
      min_capacity = 0
      max_capacity = 5
    }
    gateway_ip_configuration {
      name = "gateway-ip-config"
      subnet_id = azurerm_subnet.app_gat_subnet.id
    }
}
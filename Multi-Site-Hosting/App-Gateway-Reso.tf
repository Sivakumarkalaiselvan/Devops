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
     backend_address_pool_name = "${azurerm_virtual_network.vnet.name}-backend-add-pool1"

    # Application 1
   
    http_setting_name_app1 = "${azurerm_virtual_network.vnet.name}-http-setting-app1"
    probe_name_app1 =  "${azurerm_virtual_network.vnet.name}-probe-app1"
    listener_name_app1 ="${azurerm_virtual_network.vnet.name}-listener1"
    request_routing_rule1_name = "${azurerm_virtual_network.vnet.name}-req-rule1"


    # Application 2
    http_setting_name_app2 = "${azurerm_virtual_network.vnet.name}-http-setting-app2"
    probe_name_app2 =  "${azurerm_virtual_network.vnet.name}-probe-app2"
    listener_name_app2 ="${azurerm_virtual_network.vnet.name}-listener2"
    request_routing_rule2_name = "${azurerm_virtual_network.vnet.name}-req-rule2"
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
 # Frontend port
    frontend_port {
      name = local.frontend_port_name
      port = 80
    }

    # Frontend ip config
    frontend_ip_configuration {
      name = local.frontend_ip_configuration_name
      public_ip_address_id = azurerm_public_ip.app_gat_public_ip.id
    }
  
  # Listeners 1 for app-1
  http_listener {
    name = local.listener_name_app1
    frontend_port_name = local.frontend_port_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    protocol = "Http"
    host_names = ["app1.sivakumarsk.com"]
  }


  # Listeners 1 for app-2
  http_listener {
    name = local.listener_name_app2
    frontend_port_name = local.frontend_port_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    protocol = "Http"
    host_names = ["app2.sivakumarsk.com"]
  }

  # Applicartion 1 backend
  backend_address_pool {
    name = local.backend_address_pool_name
  }

  # Http settings - 1
  backend_http_settings {
    name = local.http_setting_name_app1
    cookie_based_affinity = "Disabled"
    #path = "/app/"                                
    protocol = "Http"
    port = 80
    request_timeout = 60
    probe_name = local.probe_name_app1
  }



  # Http settings - 2
  backend_http_settings {
    name = local.http_setting_name_app2
    cookie_based_affinity = "Disabled"
    #path = "/app/"                                
    protocol = "Http"
    port = 80
    request_timeout = 60
    probe_name = local.probe_name_app2
  } 


# Probe - 1 
  probe {
    name = local.probe_name_app1
    port = 80
    protocol = "Http"
    interval = 5
    unhealthy_threshold = 3
    timeout = 5
    path = "/app/"
    match{
        body = "app1"
        status_code = 500
    }
  }

  #Probe - 2
  probe {
    name = local.probe_name_app2
    port = 80
    protocol = "Http"
    interval = 5
    unhealthy_threshold = 3
    timeout = 5
    path = "/app/"
    match{
        body = "app1"
        status_code = 500
    }
  }

  # Rule - 1 
  request_routing_rule {
    name = local.request_routing_rule1_name
    rule_type = "Basic"
    http_listener_name = local.listener_name_app1
    backend_address_pool_name = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name_app1
  }
  

   # Rule -2
  request_routing_rule {
    name = local.request_routing_rule2_name
    rule_type = "Basic"
    http_listener_name = local.listener_name_app2
    backend_address_pool_name = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name_app1
  }


}
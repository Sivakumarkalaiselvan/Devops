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
    frontend_ip_configuration_name="${azurerm_virtual_network.vnet.name}-fipconf"
    default_redirect_configuration_name  = "redirect-confg"

    # Application 
    backend_address_pool_name = "${azurerm_virtual_network.vnet.name}-backend-add-pool1"
    http_setting_name_app1 = "${azurerm_virtual_network.vnet.name}-http-setting-app1"
    probe_name_app1 =  "${azurerm_virtual_network.vnet.name}-probe-app1"


  # Listener 1 
  frontend_port_name_http = "${azurerm_virtual_network.vnet.name}-fport-http"
  listener_name_http ="${azurerm_virtual_network.vnet.name}-listener1-http"
  request_routing_rule1_name = "${azurerm_virtual_network.vnet.name}-req-rule1-http"
   # Listener 2 
  frontend_port_name_https = "${azurerm_virtual_network.vnet.name}-fport-https"
  listener_name_https ="${azurerm_virtual_network.vnet.name}-listener2-https"
  request_routing_rule2_name = "${azurerm_virtual_network.vnet.name}-req-rule2-https"
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

# frontend_ip_configuration 
frontend_ip_configuration {
  name = local.frontend_ip_configuration_name
  public_ip_address_id = azurerm_public_ip.app_gat_public_ip.id
}

#backend addr pool
backend_address_pool {
  name = local.backend_address_pool_name
}

backend_http_settings {
  name = local.http_setting_name_app1
  protocol = "Http"
  port = 80
  cookie_based_affinity = "Disabled"
}

# Frontend port http - 80
frontend_port {
  name = local.frontend_port_name_http
  port = 80
}

# Frontend port https - 443
frontend_port {
  name = local.frontend_port_name_https
  port = 443
}

# Listener - 1 http
http_listener {
  name = local.listener_name_http
  frontend_ip_configuration_name = local.frontend_ip_configuration_name
  frontend_port_name = local.frontend_port_name_http
  protocol = "Http"
}
 # Listener - 2 https
http_listener {
  name = local.listener_name_https
  frontend_ip_configuration_name = local.frontend_ip_configuration_name
  frontend_port_name = local.frontend_port_name_https
  protocol = "Https"
}
 
request_routing_rule {
  name = local.request_routing_rule1_name
  rule_type = "Basic"
  redirect_configuration_name = local.default_redirect_configuration_name
  http_listener_name = local.listener_name_http
}

redirect_configuration {
  name = local.default_redirect_configuration_name
  redirect_type = "Permanent"
  target_listener_name = local.listener_name_https
  include_path = true
  include_query_string = true
}

request_routing_rule {
  name = local.request_routing_rule2_name
  http_listener_name = local.listener_name_https
  backend_address_pool_name = local.backend_address_pool_name
  backend_http_settings_name = local.http_setting_name_app1
  rule_type = "Basic"
}
}
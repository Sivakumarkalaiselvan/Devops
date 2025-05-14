# Resource Traffic Manager profile
resource "azurerm_traffic_manager_profile" "traffic_manager_profile"{
    name = "tf-man-${random_string.my_random.id}"
    resource_group_name = azurerm_resource_group.rg_1.name
    traffic_routing_method = "Weighted"
    dns_config {
      relative_name = "tf-man-${random_string.my_random.id}"
      ttl = 100
    }
    monitor_config {
      protocol = "HTTP"
      port = 80
      path = "/"
      interval_in_seconds = 10
      tolerated_number_of_failures = 3
      timeout_in_seconds = 9
    }
}


# Traffic Manger  Endpoint  - Project 1
resource "azurerm_traffic_manager_azure_endpoint" "tm_pro_1" {
  name = "tm-endpoint-pro-1"
  profile_id = azurerm_traffic_manager_profile.traffic_manager_profile.id
  weight = 50
  # Referncing the project - 1 ouput values
  target_resource_id = data.terraform_remote_state.project_1.outputs.web_lb_pub_id
}

# Traffic Manger  Endpoint  - Project 2
resource "azurerm_traffic_manager_azure_endpoint" "tm_pro_2" {
  name = "tm-endpoint-pro-2"
  profile_id = azurerm_traffic_manager_profile.traffic_manager_profile.id
  weight = 50
  # Referncing the project - 2 ouput values
  target_resource_id = data.terraform_remote_state.project_2.outputs.web_lb_pub_id
}
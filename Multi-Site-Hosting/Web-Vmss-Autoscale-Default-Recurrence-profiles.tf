 # Autoscaling Resource
/* resource "azurerm_monitor_autoscale_setting" "web_vmss_autoscale"{
    name = "${local.resource_name_prefix}-web-vmss-autoscale"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
    target_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
    
# Notification Block
notification {                                                             
    email {
      custom_emails = ["siva200130@gmail.com"]
    }
}

# Profile -1 = Default Profile
profile {
  name = "Default"
# Capacity Block
  capacity {                                          # Instance Limit
    default = 2
    minimum = 2
    maximum = 4
  }
# Scale-Out Rule
rule{
    scale_action {
      direction = "Increase"
      type = "ChangeCount"
      value = 1
      cooldown = "PT2M"
    }
    metric_trigger {
      metric_name = "Percentage CPU"
      metric_namespace = "Microsoft.Compute/virtualmachinescalesets"
      metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
      time_grain = "PT1M"
      statistic = "Average"
      time_window = "PT1M"
      time_aggregation = "Average"
      operator = "GreaterThan"
      threshold = 75
    }
}            # Scale Out End 
# Scale In - Rule
rule {
    scale_action {
      direction = "Decrease"
      type = "ChangeCount"
      value = 1
      cooldown = "PT2M"
    }
    metric_trigger {
      metric_name = "Percentage CPU"
      metric_namespace = "Microsoft.Compute/virtualmachinescalesets"
      metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
      time_grain = "PT1M"
      statistic = "Average"
      time_window = "PT1M"
      time_aggregation = "Average"
      operator = "LessThan"
      threshold = 25
    } 
}                  
}                                                        # End of Default Profile
# Profile-2 = Recurrence weekdays profile 
profile {
  name = "Profile-2-Weekkdays"
  # Recurrence Block
recurrence{
    timezone = "India Standard Time"
    days = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
    hours = [0]
    minutes = [0]
}
# Capacity Block
  capacity {                                          # Instance Limit
    default = 2
    minimum = 2
    maximum = 4
  }

# Scale-Out Rule
rule{
    scale_action {
      direction = "Increase"
      type = "ChangeCount"
      value = 1
      cooldown = "PT2M"
    }
    metric_trigger {
      metric_name = "Percentage CPU"
      metric_namespace = "Microsoft.Compute/virtualmachinescalesets"
      metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
      time_grain = "PT1M"
      statistic = "Average"
      time_window = "PT1M"
      time_aggregation = "Average"
      operator = "GreaterThan"
      threshold = 75
    }
}            # Scale Out End 
# Scale In - Rule
rule {
    scale_action {
      direction = "Decrease"
      type = "ChangeCount"
      value = 1
      cooldown = "PT2M"
    }
    metric_trigger {
      metric_name = "Percentage CPU"
      metric_namespace = "Microsoft.Compute/virtualmachinescalesets"
      metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
      time_grain = "PT1M"
      statistic = "Average"
      time_window = "PT1M"
      time_aggregation = "Average"
      operator = "LessThan"
      threshold = 25
    } 
}                  
}              # End of Profile - 2 
# Profile-3 = Recurrence weekend profile 
profile {
  name = "Profile-3-Weekends"
  # Recurrence Block
recurrence{
    timezone = "India Standard Time"
    days = ["Saturday", "Sunday"]
    hours = [0]
    minutes = [0]
}
# Capacity Block
  capacity {                                          # Instance Limit
    default = 2
    minimum = 2
    maximum = 4
  }

# Scale-Out Rule
rule{
    scale_action {
      direction = "Increase"
      type = "ChangeCount"
      value = 1
      cooldown = "PT2M"
    }
    metric_trigger {
      metric_name = "Percentage CPU"
      metric_namespace = "Microsoft.Compute/virtualmachinescalesets"
      metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
      time_grain = "PT1M"
      statistic = "Average"
      time_window = "PT1M"
      time_aggregation = "Average"
      operator = "GreaterThan"
      threshold = 75
    }
}            # Scale Out End 
# Scale In - Rule
rule {
    scale_action {
      direction = "Decrease"
      type = "ChangeCount"
      value = 1
      cooldown = "PT2M"
    }
    metric_trigger {
      metric_name = "Percentage CPU"
      metric_namespace = "Microsoft.Compute/virtualmachinescalesets"
      metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
      time_grain = "PT1M"
      statistic = "Average"
      time_window = "PT1M"
      time_aggregation = "Average"
      operator = "LessThan"
      threshold = 25
    } 
}                  
}              # End of Profile - 3  

} 
*/
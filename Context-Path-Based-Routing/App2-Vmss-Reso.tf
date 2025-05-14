# Web App scripts
locals{
app2_vmss_custom_data= <<CUSTOM_DATA
#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to my App2 VMSS" > /var/www/html/app2
CUSTOM_DATA
}




# Web Linux VMSS Resource
resource "azurerm_linux_virtual_machine_scale_set" "app2_vmss"{
    name = "${local.resource_name_prefix}-app2-vmss"
    computer_name_prefix = "app2-Vmss-App1"                        # Optional - Host Name
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
    sku = "Standard_DS1_V2"
    instances = 2                                                 # Manual Scaling
    admin_username= "azureuser"
    admin_ssh_key {
    username = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
    }
    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference {
      publisher = "RedHat"
      offer = "RHEL"
      sku= "83-gen2"
      version="latest"
    }
    custom_data = base64encode(local.app2_vmss_custom_data)
    upgrade_mode = "Automatic"

    network_interface {
      name = "app2-web-vmss-nic"
      primary = true
      network_security_group_id = azurerm_network_security_group.app2_vmss_nsg.id
      ip_configuration {
        name = "internal-1"
        primary = true
        subnet_id=azurerm_subnet.app_subnet.id
        load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.app_backend_pool.id]      # Associating Web VMSS with LB
        load_balancer_inbound_nat_rules_ids = [azurerm_lb_nat_pool.app_vmss_nat.id]
        application_gateway_backend_address_pool_ids = [azurerm_application_gateway.application_gateway.backend_address_pool[0].name]
      }
    }
}



# Null Resource - Like a Normal Resource in TF

resource "null_resource" "move_ssh_key_to_app_vmss"{
depends_on=[azurerm_linux_virtual_machine_scale_set.app_vmss]

# Connection Block - Used to connect the provisoners to the Azure VM
connection {
  type = "ssh"
  host = azurerm_lb.app_lb.private_ip_address
  port = 9000
  user = azurerm_linux_virtual_machine_scale_set.app_vmss.admin_username
  private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
}

# File provisioner - Copy the files from local machine to the remote machine
provisioner "file" {
  source = "ssh-keys/terraform-azure.pem"
  destination = "/tmp/terraform-azure.pem"
  when = create
  # on_failure = continue           - Even if the provisoners fails other resources get executed.
}

# Remote-exec - Execute the scripts or commands inside the vm
provisioner "remote-exec" {
  inline=["chmod 400 /tmp/terraform-azure.pem"]
}
}


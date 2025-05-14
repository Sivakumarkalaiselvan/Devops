locals{
bastion_host_custom_data= <<CUSTOM_DATA
#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo yum install -y telnet
sudo chmod -R 777 /var/www/html 
sudo mkdir index.html
sudo echo "Welcome to my bastion host linux vm" > /var/www/html/index.html
CUSTOM_DATA
}



# Public IP for Bastion Host Linux vm
resource "azurerm_public_ip" "bastion_host_pub_ip"{
    name = "${local.resource_name_prefix}-bastion-host-pub-ip"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
    allocation_method = "Dynamic"
    sku = "Basic"
}

# NIC for Bastion Host vm
resource "azurerm_network_interface" "nic_bastion_host"{
    name = "${local.resource_name_prefix}-nic-bastion-host"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
    ip_configuration {
      name = "bastion-host-ip-1"
      subnet_id= azurerm_subnet.bastion_host_subnet.id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.bastion_host_pub_ip.id
    }
}

# Bastion Host Linux VM 
resource "azurerm_linux_virtual_machine" "bastion_host_linux_vm"{
    name = "${local.resource_name_prefix}-bastion-host-linuxvm"
    computer_name = "Bastion-Host-LinuxVM"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
    size="Standard_DS1_V2"
    admin_username= "azureuser"
    network_interface_ids = [azurerm_network_interface.nic_bastion_host.id]
    admin_ssh_key{
       username = "azureuser"
       public_key = file ("${path.module}/ssh-keys/terraform-azure.pub")
    }
    os_disk{
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
      publisher = "RedHat"
      offer = "RHEL"
      sku = "83-gen2"
      version = "latest"
    }
    custom_data = base64encode(local.bastion_host_custom_data)
}
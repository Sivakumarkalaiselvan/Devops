# Web App scripts
locals{
web_app_custom_data= <<CUSTOM_DATA
#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to my WebVM App1" > /var/www/html/index.html
CUSTOM_DATA
}



# Resource : Web Linux VM
resource "azurerm_linux_virtual_machine" "web_linuxvm" {
    name = "${local.resource_name_prefix}-web-linuxvm"
    computer_name = "web-linux-vm"                              # HostName (Optional)                            
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
    size = "Standard_B2s"
    admin_username = "azureuser"
    network_interface_ids = [azurerm_network_interface.web_linuxvm_nic.id]
    admin_ssh_key{
        username = "azureuser"
        public_key = file("${path.module}/ssh-keys/terraform-azure.pub")    # file ()- Reads the content of the file and return them as string
    }                                                                       # Path.module - File system path were expression is stored 
    os_disk {
      name = "web-linuxvm-osdisk"               # Optional             
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference {
      publisher = "RedHat"
      offer = "RHEL"
      sku = "83-gen2"
      version = "latest"
    }

# Custom_data = filebase64("{path.module}/)                  if you are using file for custom data then reads the string and return them as a base64 encode 
custom_data=base64encode(local.web_app_custom_data)          # It will take a above string & then encode that as a base64
}
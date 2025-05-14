# Linux VM Resource 
resource "azurerm_linux_virtual_machine" "sivavm_linux"{
    count = var.siva_vm_instance_count                          # Meta Argument - Count
    name = "Siva-Linux-VM-${count.index}"                       # count.index = 0,1,2
    resource_group_name = azurerm_resource_group.vnet_rg.name
    location = azurerm_resource_group.vnet_rg.location
    size = "Standard_DS1_V2"
    admin_username = "azureuser"
    network_interface_ids = [element(azurerm_network_interface.nic[*].id,count.index)]       # Splat Expression . element (list,index)
    admin_ssh_key {
      username = "azureuser"
      public_key = file("${path.module}/ssh-keys-sivavm/sivavm-key.pub")
    }
   os_disk {
     storage_account_type = "Standard_LRS"
     caching = "ReadWrite"
   }
   source_image_reference {
     publisher = "RedHat"
      offer = "RHEL"
      sku = "83-gen2"
      version = "latest"
   }
}
# Linux VM Resource 
resource "azurerm_linux_virtual_machine" "skvm_linux"{
    for_each = var.sk_vm_instance_count                        # Meta Argument - for each
    name = "sk-Linux-VM-${each.key}"                         # each.key = sk1, sk2
    resource_group_name = azurerm_resource_group.vnet_rg_2.name
    location = azurerm_resource_group.vnet_rg_2.location
    size = "Standard_DS1_V2"
    admin_username = "azureuser"
    network_interface_ids = [azurerm_network_interface.nic_2[each.key].id]      
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
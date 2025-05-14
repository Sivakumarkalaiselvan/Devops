# Null Resource - Like a Normal Resource in TF

resource "null_resource" "move_ssh_key_to_bastion_host"{
depends_on=[azurerm_linux_virtual_machine.bastion_host_linux_vm]
# Connection Block - Used to connect the provisoners to the Azure VM
connection {
  type = "ssh"
  host = azurerm_linux_virtual_machine.bastion_host_linux_vm.public_ip_address
  user = azurerm_linux_virtual_machine.bastion_host_linux_vm.admin_username
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
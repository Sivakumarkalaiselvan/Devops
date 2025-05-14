# Resource - 1
resource "azurerm_resource_group" "rg_2"{
    name = "${var.res_grp_name}${random_string.my_random.id}"
    location = var.res_grp_location
}
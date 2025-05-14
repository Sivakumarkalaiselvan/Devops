# Resource - 1
resource "azurerm_resource_group" "rg_1"{
    name = "tm-${local.resource_name_prefix}-${var.resource_group_name}${random_string.my_random.id}"
    location = var.resource_group_location
    tags = local.common_tags
}
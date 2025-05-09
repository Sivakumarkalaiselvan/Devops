# Local Values Block    The Ability to change the value in a 'central place' . When expression is repeated
locals {
    owners = var.Business_Division
    environment = var.Environment_Variable
    resource_name_prefix = "${var.Business_Division}-${var.Environment_Variable}"        # O/P : East-US-HR-PRD
    common_tags = {
        owners =var.Business_Division
        environment =var.Environment_Variable
    }
}
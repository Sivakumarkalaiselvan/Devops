#Terraform Settings Block
terraform {
    required_version = ">=1.0.0"
    required_providers{
        azurerm={
            source = "hashicorp/azurerm"
            version = ">=3.0.0"
        }
    }
}


# Providers Block
provider "azurerm" {
    features {}
    subscription_id = "9950ca22-4ad3-4d10-a3e8-7fbbd00944f7"
    tenant_id = "db5b5fc8-c7d5-4cf6-a99d-0073571418a3"
}
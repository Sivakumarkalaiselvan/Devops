terraform {
    required_version = ">=1.0.0"
    required_providers{
        azurerm={
            source = "hashicorp/azurerm"
            version = ">=3.0.0"
        }
    }
}

provider "azurerm"{
    features {}
    subscription_id = "14d341a8-f86a-4ccb-be09-fb380d92c792"
}
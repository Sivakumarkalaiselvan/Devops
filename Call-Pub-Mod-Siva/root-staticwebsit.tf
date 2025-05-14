# Calling the child module from the root module 
module "sivamodules-staticwebsite" {
  source  = "Sivakumarkalaiselvan/sivamodules-staticwebsite/azurerm"
  version = "1.0.0"
  # Storage Account
storage_account_name = "sivasks"
res_grp_name = "modulereso"
res_grp_location = "eastus"
}



# Calling the child module from the root module 
module "siva_custom_module"{
    source = "./StorageAccount"


# Storage Account
storage_account_name = "sivasks"
res_grp_name = "modulereso"
res_grp_location = "eastus"
}
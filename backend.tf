terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"  
    storage_account_name = "tfstate3kzrnxfkw2"
    container_name       = "tfstate-9404e91c-cf5a-405b-9c2f-32c06896519e-connect-test"
    key                  = "terraform.tfstate"
  }
}

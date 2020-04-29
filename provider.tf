provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "~> 2.7.0"
  features {}

  subscription_id = "9404e91c-cf5a-405b-9c2f-32c06896519e"
  tenant_id       = "1d23ed27-6f11-4050-874b-7e04ca535809"
}



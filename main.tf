resource "azurerm_resource_group" "test" {
  name     = "myTestResourceGroup"
  location = "West Europe"

  tags     = {
    environment = "dev"
    costcenter  = "it"
  }
}

module "network" {
  source                 = "github.com/terraform-azurerm-modules/terraform-azure-vnet"
  resource_group         = azurerm_resource_group.test.name
  location               = azurerm_resource_group.test.location
  tags                   = azurerm_resource_group.test.tags

  vnet_name              = "hub"
  address_space          = [ "10.0.0.0/24" ]
  //dns_servers            = [ "10.0.0.68", "10.0.0.69" ]

  subnets                = {
    AzureFirewallSubnet  = "10.0.0.0/26"
    SharedServices       = "10.0.0.64/26"
    AzureBastionSubnet   = "10.0.0.192/27"
    GatewaySubnet        = "10.0.0.224/27"
  }
}
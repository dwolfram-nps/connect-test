variable "spoke_no" {
  type = list(string)
  default = [
    "24",
    "25"
    ]
}

resource "azurerm_resource_group" "Hub" {
  name     = "TF_Hub"
  location = "West Europe"

  tags     = {
    environment = "dev"
    costcenter  = "it"
  }
}

resource "azurerm_resource_group" "Spoke" {
  count = length(var.spoke_no)
  name     = "TF_Spoke${var.spoke_no[count.index]}"
  // "TF_Spoke${var.spoke_no[0]}"
  location = "West Europe"
  
  tags     = {
    environment = "dev"
    costcenter  = "it"
  }
}

module "network_Hub" {
  source                 = "github.com/terraform-azurerm-modules/terraform-azure-vnet"
  resource_group         = azurerm_resource_group.Hub.name
  location               = azurerm_resource_group.Hub.location
  tags                   = azurerm_resource_group.Hub.tags

  vnet_name              = "Hub"
  address_space          = [ "172.23.0.0/26" ]
  //dns_servers            = [ "10.0.0.68", "10.0.0.69" ]

  subnets                = {
    AzureFirewallSubnet  = "172.23.0.32/28"
    SharedServices       = "172.23.0.16/28"
    AzureBastionSubnet   = "172.23.0.48/28"
    GatewaySubnet        = "172.23.0.0/28"
  }
}

module "network_Spoke" {
  // not sure how to interate through the list of spokes
  source                 = "github.com/terraform-azurerm-modules/terraform-azure-vnet"
  resource_group         = azurerm_resource_group.Spoke[1].name
  location               = azurerm_resource_group.Spoke[1].location
  tags                   = azurerm_resource_group.Spoke[1].tags
// Will be adding variable to identify the vnet number
  vnet_name              = "Spoke${var.spoke_no[1]}"
  address_space          = [ "172.${var.spoke_no[1]}.0.0/24" ]
  //dns_servers            = [ "10.0.0.68", "10.0.0.69" ]
// Will be adding variable to identify the vnet number
  subnets                = {
    ApplicationSubnet  = "172.${var.spoke_no[1]}.0.0/26"
  }
}

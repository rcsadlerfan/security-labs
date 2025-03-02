# Sets up the base environment the virtual machines will be deployed to
resource "azurerm_resource_group" "splunk_rg" {
  name = "${var.slug}_rg"
  location = var.location
  tags = {
    source = "Splunk Lab"
  }
}

resource "azurerm_virtual_network" "splunk_vnet" {
  name = "${var.slug}_vnet"
  resource_group_name = azurerm_resource_group.splunk_rg.name
  location = azurerm_resource_group.splunk_rg.location
  address_space = [ "192.168.254.0/24" ]

  tags = {
    source = "Splunk Lab"
  }
}

resource "azurerm_subnet" "splunk_snet" {
  name = "${var.slug}_snet"
  resource_group_name = azurerm_resource_group.splunk_rg.name
  address_prefixes = [ "192.168.254.0/24" ]
  virtual_network_name = azurerm_virtual_network.splunk_rg.name
}
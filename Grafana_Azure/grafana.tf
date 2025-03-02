resource "azurerm_public_ip" "grafana_pip" {
  name = "${var.slug}_grafana_pip"
  resource_group_name = azurerm_resource_group.grafana_rg.name
  location = azurerm_resource_group.grafana_rg.location
  allocation_method = "Dynamic"

  tags = {
    source = "Grafana Lab"
  }
}

resource "azurerm_network_interface" "grafana_int" {
  name = "${var.slug}_grafana_nic"
  resource_group_name = azurerm_resource_group.grafana_rg.name
  location = azurerm_resource_group.grafana_rg.location

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.grafana_snet.id
    private_ip_address_version = "IPv4"
    private_ip_address_allocation = "Static"
    private_ip_address = "192.168.254.10"
    public_ip_address_id = azurerm_public_ip.grafana_pip.id
  }

  tags = {
    source = "Grafana Lab"
  }
}

resource "azurerm_linux_virtual_machine" "grafana_vm" {
  name = "${var.slug}_grafana_vm"
  resource_group_name = azurerm_resource_group.grafana_rg.name
  location = azurerm_resource_group.grafana_rg.location
  admin_username = "grafanaadmin"
  admin_password = var.pass
  network_interface_ids = [ azurerm_network_interface.grafana_int.id ]
  size = "Standard_B4ls_v2"

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    source = "Grafana Lab"
  }
}
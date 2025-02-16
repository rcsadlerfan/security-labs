# Setup the Linux web server
resource "azurerm_public_ip" "lin_pip" {
  name = "${var.slug}_lin_pip"
  resource_group_name = azurerm_resource_group.elk_rg.name
  location = azurerm_resource_group.elk_rg.location
  allocation_method = "Dynamic"

  tags = {
    source = "ELK Lab"
  }
}

resource "azurerm_network_interface" "lin_int" {
  name = "${var.slug}_lin_nic"
  resource_group_name = azurerm_resource_group.elk_rg.name
  location = azurerm_resource_group.elk_rg.location

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.elk_snet.id
    private_ip_address_version = "IPv4"
    private_ip_address_allocation = "Static"
    private_ip_address = "192.168.254.11"
    public_ip_address_id = azurerm_public_ip.lin_pip.id
  }

  tags = {
    source = "ELK Lab"
  }
}

resource "azurerm_linux_virtual_machine" "lin" {
  name = "${var.slug}_lin"
  resource_group_name = azurerm_resource_group.elk_rg.name
  location = azurerm_resource_group.elk_rg.location
  admin_username = "linadmin"
  admin_password = var.pass
  network_interface_ids = [ azurerm_network_interface.lin_int.id ]
  size = "Standard_B2ls_v2"

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
    source = "ELK Lab"
  }
}
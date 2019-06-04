resource "azurerm_virtual_network" "vnet" {

  name                = "${var.mynetwork}"
  address_space       = ["${var.network_adresse}"]
  location            = "${azurerm_resource_group.GROUPE-cloud.location}"
  resource_group_name = "${azurerm_resource_group.GROUPE-cloud.name}"

}

resource "azurerm_subnet" "sub" {

  name                 = "${var.mysubnet}"
  resource_group_name  = "${azurerm_resource_group.GROUPE-cloud.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${var.subnet_adresse}"
}

resource "azurerm_network_interface" "test" {
  count               = 3
  name                = "interfaceresre${count.index}"
  location            = "${azurerm_resource_group.GROUPE-cloud.location}"
  resource_group_name = "${azurerm_resource_group.GROUPE-cloud.name}"

  ip_configuration {
    name                          = "ipprivet"
    subnet_id                     = "${azurerm_subnet.sub.id}"
    private_ip_address_allocation = "Static"
    private_ip_address = "${element(var.adresselist, count.index)}"
  }

  tags = {
    environment = "staging"
  }
}
resource "azurerm_public_ip" "publicIpWeb" {
  name                         = "publicIpWeb"
  location                     = "${azurerm_resource_group.GROUPE-cloud.location}"
  resource_group_name          = "${azurerm_resource_group.GROUPE-cloud.name}"
  public_ip_address_allocation = "static"
}

resource "azurerm_network_security_group" "lesports" {
  name                = "port"
  location            = "${azurerm_resource_group.GROUPE-cloud.location}"
  resource_group_name = "${azurerm_resource_group.GROUPE-cloud.name}"

  security_rule {
    name                       = "OK-HTTP-entrant1"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "OK-HTTP-entrant2"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "OK-HTTP-sortant"
    priority                   = 1020
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "81"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "testPub" {
  name                = "interfacereseauweb"
  location            = "${azurerm_resource_group.GROUPE-cloud.location}"
  resource_group_name = "${azurerm_resource_group.GROUPE-cloud.name}"

  ip_configuration {
    name                          = "ipprivet"
    subnet_id                     = "${azurerm_subnet.sub.id}"
    private_ip_address_allocation = "Static"
    private_ip_address = "${element(var.adresselist,3)}"
    public_ip_address_id = "${azurerm_public_ip.publicIpWeb.id}"
  }

  tags = {
    environment = "staging"
  }











}
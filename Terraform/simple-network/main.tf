terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "simple_rg" {
  name     = "SimpleResourceGroup"
  location = var.location
  tags = {
    Environment = "Development ResourceGroup"
    Team        = "DevOps"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "SimpleVNet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.simple_rg.location
  resource_group_name = azurerm_resource_group.simple_rg.name
}


resource "azurerm_subnet" "web_subnet" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.simple_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "remote_subnet" {
  name                 = "remote-subnet"
  resource_group_name  = azurerm_resource_group.simple_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "simple_ip" {
  name                = "simple-ip"
  resource_group_name = azurerm_resource_group.simple_rg.name
  location            = azurerm_resource_group.simple_rg.location
  allocation_method   = "Dynamic"
  domain_name_label   = "simple-network"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Environment = "Development"
  }
}

resource "azurerm_network_interface" "web_nic" {
  name                = "web-network-interface"
  resource_group_name = azurerm_resource_group.simple_rg.name
  location            = azurerm_resource_group.simple_rg.location

  ip_configuration {
    name      = "internal"
    subnet_id = azurerm_subnet.web_subnet.id
    # private_ip_address_allocation = "Dynamic"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.5"
    public_ip_address_id          = azurerm_public_ip.simple_ip.id
  }
}

resource "azurerm_network_security_group" "web_sg" {
  name                = "web-security-group"
  resource_group_name = azurerm_resource_group.simple_rg.name
  location            = azurerm_resource_group.simple_rg.location
  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "web_subnet_web_sg_assoc" {
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_sg.id
}

resource "azurerm_network_interface" "remote_nic" {
  name                = "remote-network-interface"
  resource_group_name = azurerm_resource_group.simple_rg.name
  location            = azurerm_resource_group.simple_rg.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
    # private_ip_address_allocation = "Static"
    # private_ip_address            = "10.0.1.4"
    # public_ip_address_id          = azurerm_public_ip.simple_ip.id
  }
}

resource "azurerm_network_security_group" "remote_sg" {
  name                = "remote-security-group"
  resource_group_name = azurerm_resource_group.simple_rg.name
  location            = azurerm_resource_group.simple_rg.location
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "remote_subnet_remote_sg_assoc" {
  subnet_id                 = azurerm_subnet.remote_subnet.id
  network_security_group_id = azurerm_network_security_group.remote_sg.id
}


resource "azurerm_linux_virtual_machine" "web_linux_vm" {
  name                  = "webvm"
  resource_group_name   = azurerm_resource_group.simple_rg.name
  location              = azurerm_resource_group.simple_rg.location
  size                  = "Standard_F2"
  admin_username        = "ubuntu"
  network_interface_ids = [azurerm_network_interface.web_nic.id]
  admin_ssh_key {
    username   = "ubuntu"
    public_key = file("keys/web.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  # user_data = "base64encoded"
}

resource "azurerm_linux_virtual_machine" "remove_linux_vm" {
  name                  = "remotevm"
  resource_group_name   = azurerm_resource_group.simple_rg.name
  location              = azurerm_resource_group.simple_rg.location
  size                  = "Standard_F2"
  admin_username        = "ubuntu"
  network_interface_ids = [azurerm_network_interface.remote_nic.id]
  admin_ssh_key {
    username   = "ubuntu"
    public_key = file("keys/web.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  # user_data = "base64encoded"
}

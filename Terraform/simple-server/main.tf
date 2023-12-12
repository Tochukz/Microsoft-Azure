resource "random_pet" "rg_name" {
  prefix = var.resource_group_prefix
}

resource "azurerm_resource_group" "simple_rg" {
  name = random_pet.rg_name.id 
  location = var.location
  tags = {
    Environment = "Development ResourceGroup"
  }
}

resource "azurerm_virtual_network" "simple_vnet" {
  name = "SimpleVNet" 
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.simple_rg.location
  resource_group_name = azurerm_resource_group.simple_rg.name
}

resource "azurerm_subnet" "simple_subnet" {
  name = "SimpleSubnet"
  resource_group_name = azurerm_resource_group.simple_rg.name
  virtual_network_name = azurerm_virtual_network.simple_vnet.name
  address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "simple_ip" {
  name = "SimpleIP"
  location = azurerm_resource_group.simple_rg.location 
  resource_group_name = azurerm_resource_group.simple_rg.name
  allocation_method = "Dynamic"
}

resource "azurerm_network_security_group" "simple_sg" {
  name = "SimpleSG" 
  location = azurerm_resource_group.simple_rg.location 
  resource_group_name = azurerm_resource_group.simple_rg.name

  security_rule {
    name = "SSH"
    priority = 101
    direction = "Inbound"
    access = "Allow"
    protocol = "TCP"
    source_port_range = "22" 
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name = "HTTP"
    priority = 102
    direction = "Inbound"
    access = "Allow"
    protocol = "TCP"
    source_port_ranges = [80, 443]
    destination_port_ranges = [80, 443]
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "simple_nic" {
  name  = "SimpleNIC"
  location = azurerm_resource_group.simple_rg.location 
  resource_group_name = azurerm_resource_group.simple_rg.name
  
  ip_configuration {
    name = "SimpleNIC_Configuration"
    subnet_id = azurerm_subnet.simple_subnet.id 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.simple_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "simple_network_assoc" {
  network_interface_id = azurerm_network_interface.simple_nic.id 
  network_security_group_id = azurerm_network_security_group.simple_sg.id
}

resource "random_id" "storage_id" {
  keepers = {
    resource_group = azurerm_resource_group.simple_rg.name
  }
  byte_length = 8
}

resource "azurerm_storage_account" "simple_storage" {
  name = "diag${random_id.storage_id.hex}"
  location = azurerm_resource_group.simple_rg.location 
  resource_group_name = azurerm_resource_group.simple_rg.name
  account_tier =  "Standard" 
  account_replication_type = "LRS"
  min_tls_version = "TLS1_2"
}

resource "azurerm_linux_virtual_machine" "simple_ubuntu" {
  name =  "SimpleUbuntu"
  location = azurerm_resource_group.simple_rg.location 
  resource_group_name = azurerm_resource_group.simple_rg.name 
  network_interface_ids = [ azurerm_network_interface.simple_nic.id] 
  size = "Standard_DS1_v2" 
  computer_name = "hostname" 
  admin_username = var.username
  os_disk {
    name = "SimpleDisk" 
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy" 
    sku = "22_04-lts-gen2"
    version = "latest"
  }
  admin_ssh_key {
    username = var.username 
    public_key = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
  }
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.simple_storage.primary_blob_endpoint
  }
}

resource "azurerm_virtual_machine_extension" "nginx_install" {
  name = "NginxInstall" 
  publisher = "Microsoft.Azure.Extensions"
  virtual_machine_id = azurerm_linux_virtual_machine.simple_ubuntu.id
  type = "CustomScript" 
  type_handler_version = "2.1"
  settings = <<SETTINGS
   {   
     "script": "./install-nginx.sh"
   }
  SETTINGS
}
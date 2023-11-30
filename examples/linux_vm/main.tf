terraform {
}
provider "azurerm" {
  features {
    
  }
}

resource "tls_private_key" "rsa-4096-example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "azurerm_linux_virtual_machine" "this" {
  name                  = "pod-test"
  resource_group_name   = "myrsgpoicytest"
  location              = "eastus"
  size                  = "Standard_B1ls"
  admin_username        = "pod-admin"
  network_interface_ids = [azurerm_network_interface.nic.id]
  admin_ssh_key {
    username   = "pod-admin"
    public_key = file("id_rsa.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 32
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

resource "azurerm_public_ip" "this" {
  name = "pod-ip"
  resource_group_name = "myrsgpoicytest"
  location = "eastus"
  allocation_method = "Static"
}

resource "azurerm_network_interface" "nic" {
  name                = "pod-nic"
  resource_group_name = "myrsgpoicytest"
  location            = "eastus"
  ip_configuration {
    name      = "internal"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.this.id
    subnet_id = "/subscriptions/28e1f188-21a7-4ab2-8d0c-a2c92ee73c0e/resourceGroups/EUS-RSG-MGMT/providers/Microsoft.Network/virtualNetworks/testvnet002/subnets/app"
  }
}
 

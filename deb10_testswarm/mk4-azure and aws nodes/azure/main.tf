provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
#  version = "~> 2.12.0"
  features {}
}



resource "azurerm_resource_group" "imc" {
  name     = "imc_try02"
  location = "West Europe"
  tags = {
    environment = "Terraform Demo"
  }
}



resource "azurerm_virtual_network" "imc_net" {
  name                = "imc_net"
  resource_group_name = azurerm_resource_group.imc.name
  location            = azurerm_resource_group.imc.location
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "Terraform Demo"
  }
}

resource "azurerm_subnet" "imc_subnet" {
  name                 = "imc_subnet"
  resource_group_name  = azurerm_resource_group.imc.name
  virtual_network_name = azurerm_virtual_network.imc_net.name
  address_prefixes       = ["10.0.2.0/24"]
}



resource "azurerm_public_ip" "imc_pubip" {
  count = 5
  name                         = "imc_pubip${count.index}"
  resource_group_name          = azurerm_resource_group.imc.name
  location                     = azurerm_resource_group.imc.location
  allocation_method            = "Dynamic"
  domain_name_label            = "imc-aznode${count.index}"
  tags = {
    environment = "Terraform Demo"
  }
}

resource "azurerm_network_security_group" "imc_nsg" {
  name                = "imc_nsg"
  resource_group_name          = azurerm_resource_group.imc.name
  location                     = azurerm_resource_group.imc.location

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    }

  tags = {
    environment = "Terraform Demo"
  }
}



resource "azurerm_network_interface" "imc_nic" {
  count = 5
  name                        = "imc_nic${count.index}"
  resource_group_name          = azurerm_resource_group.imc.name
  location                     = azurerm_resource_group.imc.location

  ip_configuration {
    name                          = "imc_nic0${count.index}_cfg"
    subnet_id                     = azurerm_subnet.imc_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.imc_pubip[count.index].id
#    network_security_group_id = azurerm_network_security_group.imc_nsg.id
  }
  
  tags = {
    environment = "Terraform Demo"
  }
}


resource "azurerm_network_interface_security_group_association" "imc_nic_nsg" {
  count = 5 
    network_interface_id      = azurerm_network_interface.imc_nic[count.index].id
    network_security_group_id = azurerm_network_security_group.imc_nsg.id
}



resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group_name          = azurerm_resource_group.imc.name
    }
    byte_length = 8
}



resource "azurerm_storage_account" "imc_bootdiag" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = azurerm_resource_group.imc.name
    location                     = azurerm_resource_group.imc.location
    account_replication_type    = "LRS"
    account_tier                = "Standard"

    tags = {
        environment = "Terraform Demo"
    }
}


## this - if we want top generate key 
## i dunno if we wanna this ever
#resource "tls_private_key" "imc_ssh" {
#  algorithm = "RSA"
#  rsa_bits = 2048
#}
#
#output "tls_private_key" { value = tls_private_key.imc_ssh.private_key_pem }

## this - is out bad luck try of using azure key vault for storing out ssh-keygenned ssh2.pem key
## on creating VMs terraform says "Error "admin_ssh_key.0.public_key" is not a complete SSH2 Public Key"
## we`ll manage this later 
#data "azurerm_key_vault" "imc-keys" {
#  name                = "imc-keys"
#  resource_group_name = "imc_try01"
#}
#
#data "azurerm_key_vault_key" "pupko_ssh" {
#  name      = "pupkossh"
#  key_vault_id = data.azurerm_key_vault.imc-keys.id
#}
#
#output "key_type" {
#  value = data.azurerm_key_vault_key.pupko_ssh.key_type
#}


resource "azurerm_linux_virtual_machine" "azure_5nodes" {
count = 5
    name                  = "azure_node${count.index}"
    resource_group_name          = azurerm_resource_group.imc.name
    location                     = azurerm_resource_group.imc.location
    network_interface_ids = [azurerm_network_interface.imc_nic[count.index].id]
    size                  = "Standard_DS1_v2"

    os_disk {
        name              = "azure_node${count.index}_OS"
        caching           = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "imc-aznode${count.index}"
    admin_username = "pupko"
    disable_password_authentication = true

    admin_ssh_key {
        username       = "pupko"
        public_key     = file("~/.ssh/pupko.pub")
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.imc_bootdiag.primary_blob_endpoint
    }

    tags = {
        environment = "Terraform Demo"
    }
}

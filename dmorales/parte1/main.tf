resource "azurerm_resource_group" "rg-diplo-server" {
  name = var.rs_name
  location = var.rs_location
  tags = {
      "diplomado" = var.rs_diplomado
  }
}

resource "azurerm_public_ip" "pip-demo" {
  name = var.pip_name
  resource_group_name = azurerm_resource_group.rg-diplo-server.name
  location = azurerm_resource_group.rg-diplo-server.location
  allocation_method = var.pip_allocated_method
  tags = {
    "diplomado" = var.pip_tag_diplomado
  }
}

resource "azurerm_virtual_network" "vnet-demo" {
  name = var.vn_name
  address_space = [ var.vn_addres_space ]
   location = azurerm_resource_group.rg-diplo-server.location
  resource_group_name = azurerm_resource_group.rg-diplo-server.name
}

resource "azurerm_subnet" "subnet-demo" {
  name = var.subnet_name
  resource_group_name = azurerm_resource_group.rg-diplo-server.name
  virtual_network_name = azurerm_virtual_network.vnet-demo.name
  address_prefixes = [ var.subnet_prefixes ]
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "my_terraform_nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.rg-diplo-server.location
  resource_group_name = azurerm_resource_group.rg-diplo-server.name

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

  security_rule {
    name                       = "HTTP"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "netinter-demo" {
  name = var.ni_name
  location = azurerm_resource_group.rg-diplo-server.location
  resource_group_name = azurerm_resource_group.rg-diplo-server.name
  ip_configuration {
    name = var.ni_ip_conf_name
    subnet_id = azurerm_subnet.subnet-demo.id
    private_ip_address_allocation = var.ni_private_ip_allocation
    public_ip_address_id = azurerm_public_ip.pip-demo.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsg-netiner" {
  network_interface_id      = azurerm_network_interface.netinter-demo.id
  network_security_group_id = azurerm_network_security_group.my_terraform_nsg.id
}

resource "azurerm_linux_virtual_machine" "vm-demo" {
  name = var.vm_name
  resource_group_name = azurerm_resource_group.rg-diplo-server.name
  location = azurerm_resource_group.rg-diplo-server.location
  size = var.vm_size
  network_interface_ids = [ azurerm_network_interface.netinter-demo.id ]
  
  os_disk {
    caching = var.vm_os_disk_caching
    storage_account_type = var.vm_os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.vm_publisher
    offer = var.vm_offer
    sku = var.vm_sku
    version = var.vm_version
  }

  computer_name = var.vm_computer_name
  admin_username = var.vm_admin_username

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBCR6W9qPa0CNVND5G5owH7GgPgjLOdIACI+YnF0FRUtRwMtM2LRmJUS8VeOhAcNNMOyZy1DgOBSZyRcGM1ozlVIxzM/f2LiGEZegWsN4BUWye2XL8NeAVrWQ5ResXgG6+GjPYj+5hAQKpJ/uheI6h6NMLqmJgnEQAuVxgPFAlpjv4psphc8hBja+Y3E4zOfjWS/7T2y6DKKJ/YDQpRkaiC89OnUpN9UD1m9IYQN1xav0ehnRI3q+QBs2dI8Qi/lJiX0x2jmwK9qfzdtFafP3OFOJGB6RnR4upWdhuOZhAPMkH8NX2z46XApH0vxuYpmFgaOPHLmrwsd0+9tEDYICnpXr3a115BB6mR4wXrLJuZe9eMbd4AojzdsHBCliE++uDWmInY9BjUZGEWk/gqBlKNiIkg4hAJVlaW0c0gqoovK+e8fTeAcT7M0Uz/cVu2W0xui8NKGnc+dtY/kJota+fwl+AGk+yWP6Fpa4JHtWAEb5HAcBkHQdqiDsFWbjq+Ps= dmorales@mbdmorales.local"
  }

  admin_password = var.vm_admin_password
  disable_password_authentication = var.vm_disable_pwd_auth
}
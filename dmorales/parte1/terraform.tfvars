# Resource Group
rs_name = "rg-diplo-dm2"
rs_location = "eastus2"
rs_diplomado = "diplomado"

# Public IP
pip_name = "public_ip"
pip_allocated_method = "Static"
pip_tag_diplomado = "diplomado"
 
# Virtual network
vn_name = "diplo-net"
vn_addres_space = "10.0.0.0/16"

# Subnet
subnet_name = "sn_internal"
subnet_prefixes = "10.0.2.0/24"

# Network interface
ni_name = "diplonetworkif"
ni_ip_conf_name = "internal"
ni_private_ip_allocation = "Dynamic"

# Network Security Group
nsg_name = "diploNetworkSecurityGroup"

# Linux VM
vm_name = "diplo-vm1"
vm_size = "Standard_B1s"
vm_os_disk_caching = "ReadWrite"
vm_os_disk_storage_account_type = "Standard_LRS" 
vm_publisher = "Oracle"
vm_offer = "Oracle-Linux"
vm_sku = "ol86-lvm-gen2"
vm_version = "latest"
vm_computer_name = "vmdiplo"
vm_admin_username = "admindiplo"
vm_admin_password = "Diplo$2022"
vm_disable_pwd_auth = false


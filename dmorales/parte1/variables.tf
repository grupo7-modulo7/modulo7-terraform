# Resource Group
variable "rs_name" {}
variable "rs_location" {}
variable "rs_diplomado" {}

# Public IP
variable "pip_name" {}
variable "pip_allocated_method" {}
variable "pip_tag_diplomado" {}
 
# Virtual network
variable "vn_name" {}
variable "vn_addres_space" {}

# Subnet
variable "subnet_name" {}
variable "subnet_prefixes" {}

# Network interface
variable "ni_name" {}
variable "ni_ip_conf_name" {}
variable "ni_private_ip_allocation" {}

# Variable network security group
variable "nsg_name" {}

# Linux VM
variable "vm_name" {}
variable "vm_size" {}
variable "vm_os_disk_caching" {}
variable "vm_os_disk_storage_account_type" {}
variable "vm_publisher" {}
variable "vm_offer" {}
variable "vm_sku" {}
variable "vm_version" {}
variable "vm_computer_name" {}
variable "vm_admin_username" {}
variable "vm_admin_password" {}
variable "vm_disable_pwd_auth" {}

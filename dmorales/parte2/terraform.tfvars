# Resource group
rg_name = "rg-s2"
rg_location = "eastus2"
rg_group = 7

# Virtual network
vnet_name = "my-vnet"
vnet_address_space = ["10.10.0.0/16"]

# Subnet
subnet_name = "internal"
subnet_address_prefixes = ["10.10.5.0/24"]

# Container registry
acr_name = "dipdmoralesACR"
acr_sku = "Basic"
acr_admin_enabled = true

# Kubernetes service
aks_name = "aks-sec2"
aks_dns_prefix = "aks1"
aks_kubernetes_version = "1.24.3"
aks_rbac_enabled = true
aks_np_name = "default"
aks_np_node_count = 1
aks_np_vm_size = "Standard_D2_v2"
aks_np_enabled_auto_scaling = true
aks_np_max_count = 1 
aks_np_min_count = 1
aks_max_pods = 30
aks_sp_client_id = "<ponga_id_cliente_aqui>"
aks_sp_client_secret = "<ponga_client_secret_aqui"
aks_net_plugin = "azure"
aks_net_policy = "azure"
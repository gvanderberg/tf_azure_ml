variable "admin_username" {
  description = "The Admin Username for the Cluster."
  type        = string
}

variable "admin_password" {
  description = "The Admin Password for the Cluster."
  type        = string
}

variable "container_registry_id" {
  description = "The ID of the Container Registry."
  type        = string
}

variable "dns_service_ip" {
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns)."
  type        = string
}

variable "docker_bridge_cidr" {
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes."
  type        = string
}

variable "enable_auto_scaling" {
  description = "Should the Kubernetes Auto Scaler be enabled for this Node Pool?"
  type        = string
}

variable "kubernetes_cluster_create" {
  description = "Should the Managed Kubernetes Cluster be created."
  type        = bool
}

variable "kubernetes_cluster_name" {
  description = "The name of the Managed Kubernetes Cluster to create."
  type        = string
}

variable "kubernetes_network_name" {
  description = "Specifies the name of the Virtual Network this Subnet is located within."
  type        = string
}

variable "kubernetes_network_resource_group_name" {
  description = "Specifies the name of the resource group the Virtual Network is located in."
  type        = string
}

variable "kubernetes_network_subnet_name" {
  description = "Specifies the name of the Subnet."
  type        = string
}

variable "kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace which the OMS Agent should send data to."
  type        = string
}

variable "machine_learning_name" {
  description = "Specifies the name of the machine learning workspace."
  type        = string
}

variable "node_count" {
  description = "Number of Agents (VMs) in the Pool. Possible values must be in the range of 1 to 100 (inclusive)."
  type        = string
}

variable "resource_group_location" {
  description = "The location where the Managed Kubernetes Cluster should be created."
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the Resource Group where the Managed Kubernetes Cluster should exist."
  type        = string
}

variable "service_cidr" {
  description = "The Network Range used by the Kubernetes service."
  type        = string
}

variable "ssh_key_data" {
  description = "The Public SSH Key used to access the cluster."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(any)
}

variable "vm_size" {
  description = "The size of each VM in the Agent Pool (e.g. Standard_F1)."
  type        = string
}

variable "rg_location" {
  type = string
  default = "West Europe"
}

variable "rg_name" {
  type = string
  default = "test"
}

variable "k8s_cluster_name" {
  type = string
  default = "test"
}


variable "k8s_cluster_default_vm_size" {
  type = string
  default = "Standard_D2_v2"
}

variable "k8s_cluster_tags" {
  type = map(string)
  default = {
    Environment = "Dev"
  }
}

variable "node_pools" {
  type = list( object({
    name = string
    vm_size = string
    node_count = number
  }))
}

variable "k8s_version" {
  type = string
  default = "1.22.6"
}

variable "default_node_pool_number" {
  type = number
  default = 1
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "event_hub_name" {
  type = string
}

variable "event_hub_namespace_rg_name" {
  type = string
}

variable "event_hub_namespace_name" {
  type = string
}
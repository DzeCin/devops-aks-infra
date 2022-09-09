variable "rg_location" {
 type = string
 default = "West Europe"
}

variable "rg_name" {
 type = string
 default = "test2"
}

variable "acr_name" {
 type = string
 default = "test"
}

variable "node_pools" {
  type = list( object({
    name = string
    vm_size = string
    node_count = number
  }))
}

variable "k8s_cluster_name" {
  type = string
  default = "test"
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
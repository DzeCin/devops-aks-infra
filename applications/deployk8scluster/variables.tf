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

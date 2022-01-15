variable "rg-location" {
default = "West Europe"
}

variable "rg-name" {
 default = "test"
}

variable "k8s-cluster-name" {
 default = "test"
}


variable "k8s-cluster-default-vm-size" {
  default = "Standard_D2_v2"
}

variable "k8s-cluster-tags" {
  type = map(string)
  default = {
    Environment = "Production"
  }
}

variable "node-pools" {
  type = list( object({
    name = string
    vm_size = string
    node_count = number
  }))
}
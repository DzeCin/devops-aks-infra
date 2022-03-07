variable "rg-location" {
  type = string
  default = "West Europe"
}

variable "rg-name" {
  type = string
  default = "test"
}

variable "k8s-cluster-name" {
  type = string
  default = "test"
}


variable "k8s-cluster-default-vm-size" {
  type = string
  default = "Standard_D2_v2"
}

variable "k8s-cluster-tags" {
  type = map(string)
  default = {
    Environment = "Dev"
  }
}

variable "node-pools" {
  type = list( object({
    name = string
    vm_size = string
    node_count = number
  }))
}

variable "k8s-version" {
  type = string
  default = "1.22.6"
}

variable "default-node-pool-number" {
  type = number
  default = 1
}
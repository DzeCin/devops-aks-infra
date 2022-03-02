#!/bin/bash
set -e
terraform refresh
terraform apply -auto-approve
terraform output -raw kube_config  > kubeconfig

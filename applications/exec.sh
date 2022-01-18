#!/bin/bash
terraform init
terraform refresh
terraform apply -auto-approve && terraform output kube_config > kubeconfig

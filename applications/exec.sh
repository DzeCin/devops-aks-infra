#!/bin/bash
<<<<<<< HEAD
set -e
terraform refresh
terraform apply -auto-approve
terraform output -raw kube_config  > kubeconfig
>>>>>>> 8272f1b (adding az container registry)

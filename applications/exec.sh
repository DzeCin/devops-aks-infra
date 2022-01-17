#!/bin/bash

terraform refresh
terraform apply -auto-approve && terraform output kube_config > kubeconfig
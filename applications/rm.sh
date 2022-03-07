#!/bin/bash
set -e

# deploy ingress and jenkins


terraform -chdir=deploybasedevops destroy -auto-approve

# deploy cluster
terraform -chdir=deployk8scluster destroy -auto-approve



#!/bin/bash
set -e

# deploy cluster
terraform -chdir=deployk8scluster init -upgrade
terraform -chdir=deployk8scluster refresh
terraform -chdir=deployk8scluster apply -auto-approve
terraform -chdir=deployk8scluster output -raw kube_config  > ../kubeconfig

# login to acr

docker login -p "$(terraform -chdir=deployk8scluster output -raw acr_admin_password)" -u "$(terraform -chdir=deployk8scluster output -raw acr_admin_username)" "$(terraform -chdir=deployk8scluster output -raw acr_url)"

# deploy ingress and jenkins

terraform -chdir=deploybasedevops init
terraform -chdir=deploybasedevops refresh
terraform -chdir=deploybasedevops apply -auto-approve

# Wait for secrets to be created
sleep 3

terraform -chdir=getinfos init
terraform -chdir=getinfos refresh
terraform -chdir=getinfos apply -auto-approve

terraform -chdir=getinfos output -json jenkins-secret | jq -r '.["jenkins-admin-password"]' | base64 -d >> ../jenkins-creds
printf "\n" >> ../jenkins-creds
terraform -chdir=getinfos output -json jenkins-secret | jq -r '.["jenkins-admin-user"]' | base64 -d >> ../jenkins-creds

#terraform -chdir=getinfos output -json grafana-secret | jq -r '.["admin-password"]' | base64 -d >> ../grafana-creds
#printf "\n" >> ../grafana-creds
#terraform -chdir=getinfos output -json grafana-secret | jq -r '.["admin-user"]' | base64 -d >> ../grafana-creds

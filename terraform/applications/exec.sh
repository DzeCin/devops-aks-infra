#!/bin/bash

set -xe

# Init terraform apps
terraform -chdir=deployK8sCluster init -upgrade
terraform -chdir=deployBaseDevops init -upgrade
terraform -chdir=deployMonitoring init -upgrade


# Check conf

terraform -chdir=deployK8sCluster validate
terraform -chdir=deployMonitoring validate
terraform -chdir=deployBaseDevops validate



# deploy monitoring (event hub + log analytics workspace + consumer group)

terraform -chdir=deployMonitoring refresh
terraform -chdir=deployMonitoring apply -auto-approve

sleep 3

# save some needed ids and names

LOG_ANALYTICS_WORKSPACE_ID=$(terraform -chdir=deployMonitoring output -raw log_analytics_workspace_id)
EVENT_HUB_NAME=$(terraform -chdir=deployMonitoring output -raw event_hub_name)
EVENT_HUB_NAMESPACE_NAME=$(terraform -chdir=deployMonitoring output -raw event_hub_namespace_name)
EVENT_HUB_NAMESPACE_RG_NAME=$(terraform -chdir=deployMonitoring output -raw event_hub_namespace_rg_name)

# deploy cluster

terraform -chdir=deployK8sCluster refresh \
  -var="log_analytics_workspace_id=$LOG_ANALYTICS_WORKSPACE_ID" \
  -var="event_hub_name=$EVENT_HUB_NAME" \
  -var="event_hub_namespace_name=$EVENT_HUB_NAMESPACE_NAME" \
  -var="event_hub_namespace_rg_name=$EVENT_HUB_NAMESPACE_RG_NAME"

terraform -chdir=deployK8sCluster apply -auto-approve \
  -var="log_analytics_workspace_id=$LOG_ANALYTICS_WORKSPACE_ID" \
  -var="event_hub_name=$EVENT_HUB_NAME" \
  -var="event_hub_namespace_name=$EVENT_HUB_NAMESPACE_NAME" \
  -var="event_hub_namespace_rg_name=$EVENT_HUB_NAMESPACE_RG_NAME"

terraform -chdir=deployK8sCluster output -raw kube_config  > ../kubeconfig

# login to acr

docker login -p "$(terraform -chdir=deployK8sCluster output -raw acr_admin_password)" -u "$(terraform -chdir=deployk8scluster output -raw acr_admin_username)" "$(terraform -chdir=deployk8scluster output -raw acr_url)"

# deploy ingress and jenkins

terraform -chdir=deployBaseDevops refresh
terraform -chdir=deployBaseDevops apply -auto-approve

# Wait for secrets to be created

sleep 3

# get needed infos

terraform -chdir=getinfos init
terraform -chdir=getinfos refresh
terraform -chdir=getinfos apply -auto-approve

# Output credentials

terraform -chdir=getinfos output -json jenkins_secret | jq -r '.["jenkins-admin-password"]' | base64 -d > ../jenkins-creds
printf "\n" >> ../jenkins-creds
terraform -chdir=getinfos output -json jenkins_secret | jq -r '.["jenkins-admin-user"]' | base64 -d >> ../jenkins-creds

terraform -chdir=getinfos output -json grafana_secret | jq -r '.["admin-password"]' | base64 -d > ../grafana-creds
printf "\n" >> ../grafana-creds
terraform -chdir=getinfos output -json grafana_secret | jq -r '.["admin-user"]' | base64 -d >> ../grafana-creds

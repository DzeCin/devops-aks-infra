#!/bin/bash

set -xe

LOG_ANALYTICS_WORKSPACE_ID=$(terraform -chdir=deployMonitoring output -raw log_analytics_workspace_id)
EVENT_HUB_NAME=$(terraform -chdir=deployMonitoring output -raw event_hub_name)
EVENT_HUB_NAMESPACE_NAME=$(terraform -chdir=deployMonitoring output -raw event_hub_namespace_name)
EVENT_HUB_NAMESPACE_RG_NAME=$(terraform -chdir=deployMonitoring output -raw event_hub_namespace_rg_name)


# rm ingress and jenkins
# terraform -chdir=deployBaseDevops destroy -auto-approve

# rm ./path/file
terraform -chdir=deployK8sCluster destroy -auto-approve \
  -var="log_analytics_workspace_id=$LOG_ANALYTICS_WORKSPACE_ID" \
  -var="event_hub_name=$EVENT_HUB_NAME" \
  -var="event_hub_namespace_name=$EVENT_HUB_NAMESPACE_NAME" \
  -var="event_hub_namespace_rg_name=$EVENT_HUB_NAMESPACE_RG_NAME"

# rm monitoring
terraform -chdir=deployMonitoring destroy -auto-approve


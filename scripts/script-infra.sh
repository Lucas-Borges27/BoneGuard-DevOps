#!/bin/bash
# =============================================================
# script-infra.sh — Provisionamento BoneGuard no Azure
# Execução: bash scripts/script-infra.sh
# Pré-requisito: az login já realizado
# =============================================================

set -e

RESOURCE_GROUP="rg-boneguard-gs"
LOCATION="eastus"
APP_SERVICE_PLAN="plan-boneguard"
BONEGUARD_APP="app-boneguard-service"
NOTIFICATION_APP="app-notification-service"

echo "=== [1/4] Criando Resource Group ==="
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION

echo "=== [2/4] Criando App Service Plan (Linux, Java) ==="
az appservice plan create \
  --name $APP_SERVICE_PLAN \
  --resource-group $RESOURCE_GROUP \
  --is-linux \
  --sku F1

echo "=== [3/4] Criando Web App — boneguard-service ==="
az webapp create \
  --resource-group $RESOURCE_GROUP \
  --plan $APP_SERVICE_PLAN \
  --name $BONEGUARD_APP \
  --runtime "JAVA:17-java17"

echo "=== [4/4] Criando Web App — notification-service ==="
az webapp create \
  --resource-group $RESOURCE_GROUP \
  --plan $APP_SERVICE_PLAN \
  --name $NOTIFICATION_APP \
  --runtime "JAVA:17-java17"

echo ""
echo "============================================="
echo " Infraestrutura provisionada com sucesso!"
echo "============================================="
echo " BoneGuard Service : https://$BONEGUARD_APP.azurewebsites.net"
echo " Notification Svc  : https://$NOTIFICATION_APP.azurewebsites.net"
echo "============================================="

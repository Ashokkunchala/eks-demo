#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="monitoring"

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts >/dev/null
helm repo update >/dev/null
kubectl get namespace "$NAMESPACE" >/dev/null 2>&1 || kubectl create namespace "$NAMESPACE"

helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack   --namespace "$NAMESPACE"   --set grafana.service.type=ClusterIP   --set prometheus.prometheusSpec.retention=7d

echo "Monitoring deployed."

locals {
  # Sanitizar nombre para storage account (solo minúsculas y números, max 24 chars)
  storage_name = lower(replace("tfsa${var.prefix}${var.environment}", "/[^a-z0-9]/", ""))

  # Tags comunes para todos los recursos
  common_tags = {
    environment = var.environment
    managed_by  = "terraform"
    project     = var.prefix
  }

  # ArgoCD installation script template
  argocd_install_script_template = <<-EOT
    echo "Getting AKS credentials..."
    az aks get-credentials --resource-group %s --name %s --overwrite-existing

    echo "Creating argocd namespace..."
    kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

    echo "Installing ArgoCD..."
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

    echo "Waiting for ArgoCD to be ready..."
    kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd || true

    echo "ArgoCD installed successfully!"
    echo "To get the initial admin password, run:"
    echo "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
  EOT
}

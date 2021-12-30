terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">=2.16.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.7.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.4.1"
    }
  }
}

provider "digitalocean" {
  token = var.token_api
}

provider "kubernetes" {
  host  = digitalocean_kubernetes_cluster.kube_cluster.endpoint
  token = digitalocean_kubernetes_cluster.kube_cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.kube_cluster.kube_config[0].cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes {
    host  = digitalocean_kubernetes_cluster.kube_cluster.endpoint
    token = digitalocean_kubernetes_cluster.kube_cluster.kube_config[0].token
    cluster_ca_certificate = base64decode(
      digitalocean_kubernetes_cluster.kube_cluster.kube_config[0].cluster_ca_certificate
    )
  }
}
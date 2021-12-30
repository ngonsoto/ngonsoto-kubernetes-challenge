resource "digitalocean_kubernetes_cluster" "kube_cluster" {
  name    = "terraform-kube-cluster"
  region  = var.region
  version = var.kubernetes_version

  tags = ["do-challenge-cluster"]

  node_pool {
    name       = "do-challenge-pool"
    size       = var.node_size
    auto_scale = false
    node_count = var.node_count
    tags       = ["do-challenge-node"]
  }

}

resource "kubernetes_service" "kibana_load_balancer" {
  metadata {
    name = "kibana-load-balancer"
  }

  spec {
    selector = {
      app = "kibana"
    }
    port {
      port        = 80
      target_port = 5601
    }
    type = "LoadBalancer"
  }
}
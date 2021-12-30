output "kibana_load_balancer_ip" {
  description = "URL of load balancer"
  value = kubernetes_service.kibana_load_balancer.status[0].load_balancer[0].ingress[0].ip
}

output "cluster_connection" {
  description = "Command to connect to cluster from kubectl"
  value = "doctl kubernetes cluster kubeconfig save ${digitalocean_kubernetes_cluster.kube_cluster.id}"
}
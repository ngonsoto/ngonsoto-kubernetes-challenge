resource "helm_release" "elasticsearch" {
  name    = "elasticsearch"
  repository = "https://helm.elastic.co"
  chart   = "elasticsearch"
  version = var.elasticsearch_version

  values = [
    "${file("elasticsearch-values.yaml")}"
  ]
}

resource "helm_release" "kibana" {
  name    = "kibana"
  repository = "https://helm.elastic.co"
  chart   = "kibana"
  version = var.kibana_version
}

resource "helm_release" "fluentbit" {
  name    = "fluentbit"
  repository = "https://fluent.github.io/helm-charts"
  chart   = "fluent-bit"
  version = var.fluentbit_version
}
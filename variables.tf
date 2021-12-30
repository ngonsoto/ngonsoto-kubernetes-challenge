variable "token_api" {
    description = "DigitalOcean Token API"
    type = string
}

variable "region" {  
    description = "DigitalOcean region to deploy"  
    type        = string  
    default     = "nyc1"
}

variable "node_size" {  
    description = "Size of the nodes for the cluster (doctl kubernetes options sizes)"  
    type        = string  
    default     = "s-2vcpu-4gb"
}

variable "node_count" {
    description = "Number of nodes to run the application"
    type = number
    default = 3
}

variable "kubernetes_version" {
    description = "Version of the K8s cluster"
    type = string
    default = "1.21.5-do.0"
}

variable "elasticsearch_version" {
    description = "Version of the ElasticSearch Helm chart"
    type = string
    default = "7.16.2"
}

variable "kibana_version" {
    description = "Version of the Kibana Helm chart"
    type = string
    default = "7.16.2"
}

variable "fluentbit_version" {
    description = "Version of the FluentBit Helm chart"
    type = string
    default = "0.19.16"
}
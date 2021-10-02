terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.12.0"
    }
  }
}

provider "digitalocean" {
  token = "<seu-token>"
}

resource "digitalocean_kubernetes_cluster" "k8s_labs" {
  name   = "meu-cluster"
  region = "nyc1"
  version = "1.21.3-do.0"

  node_pool {
    name       = "default-pool"
    size       = "s-2vcpu-4gb"
    node_count = 4
  }
}

resource "local_file" "k8s_config" {
    content = digitalocean_kubernetes_cluster.k8s_labs.kube_config.0.raw_config
    filename = "kube_config"
}
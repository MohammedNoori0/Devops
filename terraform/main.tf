terraform {
  required_providers {
    kubectl = {
      source  = "derailed/kubectl"
      version = "~> 1.0" # You can specify the latest version here
    }
  }
}

provider "kubectl" {
  config_path = "~/.kube/config" # Make sure this path points to your kubeconfig
}

resource "kubectl_deployment" "my_app" {
  metadata {
    name      = "my-node-app"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "my-node-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "my-node-app"
        }
      }

      spec {
        container {
          name  = "my-node-app"
          image = "your-docker-image:tag" # Replace with your Docker image
          ports {
            container_port = 3000 # Adjust this based on your app
          }
        }
      }
    }
  }
}

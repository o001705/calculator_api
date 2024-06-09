provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name                    = "gke-vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "gke-subnetwork"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.name
}

# Firewall rule to allow ingress on port 8080
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-8080"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gke-node"]
}

# Firewall rule to allow ingress on port 443 for Kubernetes API server
resource "google_compute_firewall" "allow_k8s_api" {
  name    = "allow-k8s-api"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gke-node"]
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  initial_node_count = 2

  network    = google_compute_network.vpc_network.name
  subnetwork = google_compute_subnetwork.subnetwork.name

  node_config {
    machine_type = var.machine_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    tags = ["gke-node"]
  }

  remove_default_node_pool = true

  node_pool {
    name       = "default-pool"
    initial_node_count = 2

    node_config {
      machine_type = var.machine_type

      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform",
      ]

      tags = ["gke-node"]
    }

    management {
      auto_upgrade = true
      auto_repair  = true
    }
  }
}

provider "kubernetes" {
  host                   = google_container_cluster.primary.endpoint
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = var.namespace_name
  }
}

data "google_client_config" "default" {}

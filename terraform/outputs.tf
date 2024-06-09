output "endpoint" {
  description = "The endpoint of the GKE cluster"
  value       = google_container_cluster.primary.endpoint
}

output "cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.primary.name
}

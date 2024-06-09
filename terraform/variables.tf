variable "project_id" {
  description = "The ID of the project in which to create the GKE cluster"
  type        = string
  default     = "bright-coyote-425316-u3"
}

variable "region" {
  description = "The region in which to create the GKE cluster"
  type        = string
  default     = "asia-south1"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "calculator-api-gke-cluster"
}

variable "node_count" {
  description = "The number of nodes in the GKE cluster"
  type        = number
  default     = 2
}

variable "machine_type" {
  description = "The type of machine to use for the nodes"
  type        = string
  default     = "e2-medium"
}

variable "namespace_name" {
  description = "The name of the namespace to create"
  type        = string
  default     = "calculator-api-namespace"
}

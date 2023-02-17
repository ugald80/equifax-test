/*
  provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.client_certificate)
}

module "kubernetes-engine_asm" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/asm"
  version = "25.0.0"

  project_id            = var.project_id
  cluster_name          = google_container_cluster.primary.name
  cluster_location      = google_container_cluster.primary.location
  #enable_cni        = true
  
  module_depends_on = [
    google_container_cluster.primary
  ]
}
*/
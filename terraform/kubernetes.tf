resource "google_container_cluster" "primary" {
  name     = "${var.project_alias}-gke-cluster"
  location = "us-central1-a"

  remove_default_node_pool = true
  initial_node_count = 1

  dns_config {
    cluster_dns = "CLOUD_DNS"
    cluster_dns_scope = "CLUSTER_SCOPE"
    cluster_dns_domain = var.project_alias
  }
  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${var.project_alias}-pool"
  location   = "us-central1-a"
  cluster    = google_container_cluster.primary.name
  node_count = 3

  node_config {
    preemptible  = true
    machine_type = "e2-standard-2"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = data.google_service_account.myaccount.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "db_instance" {
  name             = "${var.project_alias}-db-instance-${random_id.db_name_suffix.hex}"
  region           = "us-central1"
  database_version = "POSTGRES_14"
  deletion_protection = false

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = google_compute_network.private_network.id
      #enable_private_path_for_google_cloud_services = true

      /*dynamic "authorized_networks" {
        for_each = google_compute_instance.bastion
        iterator = apps

        content {
          name  = apps.value.name
          value = apps.value.network_interface.0.access_config.0.nat_ip
        }
      }*/
    }
  }
}

resource "google_sql_database" "database" {
  name     = "${var.project_alias}-database"
  instance = google_sql_database_instance.db_instance.name
}
resource "google_sql_user" "users" {
  name     = var.project_alias
  instance = google_sql_database_instance.db_instance.name
  password = var.db_password
}
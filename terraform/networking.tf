resource "google_compute_network" "private_network" {
  name = "${var.project_alias}-private-network"
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "${var.project_alias}-private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
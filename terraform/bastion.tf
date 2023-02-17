resource "google_compute_instance" "bastion" {
  name         = "${var.project_alias}-bastion"
  machine_type = "e2-standard-2"
  zone         = "us-central1-a"
  count        = 1

  allow_stopping_for_update = true
  tags = [var.project_alias]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        project = var.project_alias
      }
    }
  }

  // Local SSD disk
  #scratch_disk {
  #  interface = "SCSI"
  #}

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  #metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.myaccount.email
    scopes = ["cloud-platform"]
  }
}
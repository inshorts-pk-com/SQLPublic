#********* SQL Use case ********
#****** Public Testing *******
#****** Public Testing *******
# 1. Created VPC and Auto subnet
# 2. Created External Static IP on VPC for VM instance
# 3. Created SQL Instance
# 4. Created firewall with port and tag to connect vm and SQL database
# 5. Created VM instance (Startup script for installing MySQL-Server)
# 6. Created SQL Database 
# 7. Created SQL user
# 8. Pulled Repository from Prem

resource "google_sql_database_instance" "instance" {
  name   = var.sqlname
  region = var.sqlregion
  settings {
    tier = var.sqltier
    ip_configuration {
      authorized_networks {
        name = "vmconnection"
        value = google_compute_address.static.address
      }
    }
  }
  database_version = var.sqlversion
  deletion_protection = false
}

resource "google_sql_database" "sqldb" {
  name = var.dbname
  instance = google_sql_database_instance.instance.name
}

resource "google_compute_network" "vpc-manual" {
  name = var.vpcsql
  auto_create_subnetworks = var.subnetsql
}

resource "google_compute_address" "static" {
  name = var.staticip
  region = var.region
}

resource "google_compute_instance" "sqlterra" {
  name = var.vmname
  machine_type = var.vmtype
  zone = var.vmzone
  tags = ["http-server","https-server"]
  metadata_startup_script = file("/home/premrajaeee/CloudSQL/script.sh")
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = google_compute_network.vpc-manual.name
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
}

resource "google_compute_firewall" "http" {
  name = var.sqlfirewall
  network = google_compute_network.vpc-manual.name
  allow {
    protocol = "tcp"
    ports = ["80","22"]
  }
  allow {
    protocol = "icmp"
  }
    source_ranges = ["0.0.0.0/0"]
  target_tags = ["http-server"]
}

resource "google_sql_user" "user" {
  name = var.sqluser
  instance = google_sql_database_instance.instance.name
}
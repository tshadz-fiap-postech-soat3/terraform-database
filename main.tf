terraform {
  cloud {
    organization = "fiap-postech-tsombra"
    workspaces {
      name = "terraform-cloud-database-product-api"
    }
  }
}

provider "google" {
  project     = var.GCP_ID
  region      = var.DB_REGION
  credentials = var.CREDENTIALS
}

resource "google_sql_user" "mydatabase_user" {
  name     = var.DB_USER
  instance = google_sql_database_instance.mydatabase.name
  password = var.DB_PASSWORD
}

resource "google_sql_database_instance" "mydatabase" {
  name             = var.DB_HOST
  database_version = "MYSQL_8_0"
  region           = var.DB_REGION
  settings {
    tier              = var.DB_TIER
    activation_policy = "ALWAYS"
    ip_configuration {
      ipv4_enabled = true
    }
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
      start_time         = "23:00"
    }
    disk_autoresize = true
    disk_size       = 10
    maintenance_window {
      day  = 1
      hour = 0
    }
  }
}

resource "google_sql_database" "mydatabase_db" {
  name      = var.DB_HOST
  instance  = google_sql_database_instance.mydatabase.name
  charset   = "utf8"
  collation = "utf8_general_ci"
}

terraform {
  cloud {
    organization = "fiap-postech-tsombra"
    workspaces {
      name = "terraform-cloud-test"
    }
  }
}

provider "google" {
  project = var.GCP_ID
  region  = var.DB_REGION
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
}

resource "google_sql_database" "mydatabase_db" {
  name      = var.DB_HOST
  instance  = google_sql_database_instance.mydatabase.name
  charset   = "utf8"
  collation = "utf8_general_ci"
}

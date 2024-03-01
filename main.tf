module "fiap-food-db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "13.0.1"

  availability_type = "REGIONAL"
  backup_configuration = {
    enabled                        = true
    start_time                     = "4:00" # 11PM EST  #specified in a 24-hour time format, in the UTC±00 time zone, and specifies the start of a 4-hour backup window
    location                       = null
    point_in_time_recovery_enabled = false
    transaction_log_retention_days = null
    retained_backups               = 365
    retention_unit                 = "COUNT"
  }
  database_flags      = [{ name = "autovacuum", value = "off" }, { name = "max_connections", value = 300 }]
  database_version    = "POSTGRES_14"
  db_name             = "fiap-food"
  deletion_protection = false
  disk_size           = 10
  enable_default_db   = true
  enable_default_user = true
  ip_configuration = {
    ipv4_enabled        = false
    require_ssl         = true
    private_network     = var.private_network
    allocated_ip_range  = null
    authorized_networks = []
  }
  maintenance_window_day          = 7
  maintenance_window_hour         = 12
  maintenance_window_update_track = "stable"
  name                            = var.database_instance_name
  project_id                      = var.project_id
  region                          = var.region
  tier                            = var.database_tier
  user_labels                     = module.labels.common_labels
  user_name                       = "fiap"
  zone                            = "us-east1-b"
}

resource "kubernetes_secret" "fiap-food-db" {
  metadata {
    name      = "fiap-food-db"
    namespace = kubernetes_namespace.defectdojo.metadata[0].name
  }

  data = {
    db_user_password = module.fiap-food-db.generated_user_password
  }
}

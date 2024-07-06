variable "DB_PASSWORD" {
  description = "Database root password"
}

variable "DB_USER" {
  description = "Database root user"
}

variable "DB_HOST" {
  description = "Database host"
}

variable "DB_REGION" {
  description = "Database region"
}

variable "DB_TIER" {
  description = "Database tier"
  default = "db-f1-micro"
}

variable "GCP_ID" {
  description = "Project ID"
}

variable "CREDENTIALS" {
  description = "Cloud Sql Service Credentials"
}

variable "IMAGE_NAME" {
  description = "Image Name"
}

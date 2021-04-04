variable "app_name" {}

variable "db_name" {}

variable "db_username" {}

variable "db_password" {}

variable "db_host" {}

variable "db_database" {}

variable "master_key" {}

variable "apps_name" {
  type    = list(string)
  default = ["nginx", "rails"]
}

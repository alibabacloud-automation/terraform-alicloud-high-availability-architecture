variable "rds_config" {
  description = "The parameters of rds."
  type = object({
    # instance
    engine                   = optional(string, "MySQL")
    engine_version           = optional(string, "8.0")
    instance_type            = optional(string, "mysql.x2.medium.2c")
    instance_storage         = optional(number, 20)
    instance_charge_type     = optional(string, "Postpaid")
    monitoring_period        = optional(string, "60")
    db_instance_storage_type = optional(string, "cloud_essd")
    instance_name            = optional(string, null)
    # account
    account_name     = string
    account_password = string
    account_type     = optional(string, null)
    # database
    database_name = string
    character_set = optional(string, null)
  })
  default = {
    account_name     = "tf_example"
    account_password = "Example1234"
    account_type     = "Super"
    database_name    = "tf_example"
    character_set    = "utf8mb4"
  }
}

variable "vpc_config" {
  description = "The parameters of vpc."
  type = object({
    cidr_block = string
    vpc_name   = optional(string, null)
  })
}

variable "zone_ids" {
  description = "The zone ID of vSwitches."
  type        = list(string)
}

variable "vswitches_config" {
  description = "The parameters of vswitches."
  type        = map(list(string))

  validation {
    condition     = length(var.vswitches_config) == 3
    error_message = "The length of vswitches_config must be three."
  }

  validation {
    condition     = contains(keys(var.vswitches_config), "alb") && contains(keys(var.vswitches_config), "ecs") && contains(keys(var.vswitches_config), "rds")
    error_message = "The keys must be alb, ecs and rds."
  }
}



variable "alb_load_balancer_config" {
  description = "The parameters used to create alb load balancer."
  type = object({
    address_type           = optional(string, "Internet")
    address_allocated_mode = optional(string, "Fixed")
    pay_type               = optional(string, "PayAsYouGo")
    load_balancer_edition  = optional(string, "Basic")
  })
  default = {}

}

variable "security_group_name" {
  description = "The name of security group."
  type        = string
  default     = null
}

variable "ecs_config" {
  description = "The parameters of instance."
  type = object({
    image_id                   = optional(string, "aliyun_3_9_x64_20G_alibase_20231219.vhd")
    instance_name              = optional(string, null)
    description                = optional(string, null)
    instance_charge_type       = optional(string, "PostPaid")
    instance_type              = optional(string, "ecs.e-c1m2.large")
    system_disk_category       = optional(string, "cloud_essd_entry")
    password                   = optional(string, null)
    internet_max_bandwidth_out = optional(number, 100)
    internet_charge_type       = optional(string, "PayByTraffic")
  })
  default = {}
}


variable "rds_config" {
  description = "The parameters of rds."
  type = object({
    engine                   = optional(string, "MySQL")
    engine_version           = optional(string, "8.0")
    instance_type            = optional(string, "mysql.x2.medium.2c")
    instance_storage         = optional(number, 20)
    instance_charge_type     = optional(string, "Postpaid")
    monitoring_period        = optional(string, "60")
    db_instance_storage_type = optional(string, "cloud_essd")
    instance_name            = optional(string, null)

    account_name     = string
    account_password = string

    database_name = string
  })
}

variable "tags" {
  description = "The tags of the resource."
  type        = map(string)
  default     = {}
}

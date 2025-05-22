resource "alicloud_vpc" "default" {
  cidr_block = var.vpc_config.cidr_block
  vpc_name   = var.vpc_config.vpc_name
  tags       = var.tags
}

resource "alicloud_vswitch" "alb" {
  for_each = { for i, v in var.vswitches_config["alb"] : i => v }

  vpc_id       = alicloud_vpc.default.id
  zone_id      = var.zone_ids[each.key]
  cidr_block   = each.value
  vswitch_name = "alb-vsw-${each.key}"
}

resource "alicloud_vswitch" "ecs" {
  for_each = { for i, v in var.vswitches_config["ecs"] : i => v }

  vpc_id       = alicloud_vpc.default.id
  zone_id      = var.zone_ids[each.key]
  cidr_block   = each.value
  vswitch_name = "ecs-vsw-${each.key}"
}

resource "alicloud_vswitch" "rds" {
  for_each = { for i, v in var.vswitches_config["rds"] : i => v }

  vpc_id       = alicloud_vpc.default.id
  zone_id      = var.zone_ids[each.key]
  cidr_block   = each.value
  vswitch_name = "rds-vsw-${each.key}"
}

# ALB Load Balancer
resource "alicloud_alb_load_balancer" "default" {
  vpc_id                 = alicloud_vpc.default.id
  address_type           = var.alb_load_balancer_config.address_type
  address_allocated_mode = var.alb_load_balancer_config.address_allocated_mode
  dynamic "zone_mappings" {
    for_each = alicloud_vswitch.alb
    content {
      vswitch_id = zone_mappings.value.id
      zone_id    = zone_mappings.value.zone_id
    }
  }
  load_balancer_billing_config {
    pay_type = var.alb_load_balancer_config.pay_type
  }
  load_balancer_edition = var.alb_load_balancer_config.load_balancer_edition
}


# Security Group
resource "alicloud_security_group" "default" {
  vpc_id              = alicloud_vpc.default.id
  security_group_name = var.security_group_name
}

resource "alicloud_security_group_rule" "sg_rule_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "sg_rule_https" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "443/443"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}


# ECS Instances
resource "alicloud_instance" "default" {
  for_each = alicloud_vswitch.ecs

  availability_zone          = each.value.zone_id
  instance_charge_type       = var.ecs_config.instance_charge_type
  image_id                   = var.ecs_config.image_id
  instance_type              = var.ecs_config.instance_type
  system_disk_category       = var.ecs_config.system_disk_category
  security_groups            = [alicloud_security_group.default.id]
  vswitch_id                 = each.value.id
  instance_name              = var.ecs_config.instance_name
  password                   = var.ecs_config.password
  internet_max_bandwidth_out = var.ecs_config.internet_max_bandwidth_out
  internet_charge_type       = var.ecs_config.internet_charge_type
}

locals {
  rds_vsw_ids = [for vsw in alicloud_vswitch.rds : vsw.id]
}

resource "alicloud_db_instance" "default" {
  zone_id_slave_a          = var.zone_ids[1]
  vswitch_id               = join(",", local.rds_vsw_ids)
  engine                   = var.rds_config.engine
  engine_version           = var.rds_config.engine_version
  instance_type            = var.rds_config.instance_type
  instance_storage         = var.rds_config.instance_storage
  instance_charge_type     = var.rds_config.instance_charge_type
  instance_name            = var.rds_config.instance_name
  monitoring_period        = var.rds_config.monitoring_period
  db_instance_storage_type = var.rds_config.db_instance_storage_type
  security_group_ids       = [alicloud_security_group.default.id]
}

resource "alicloud_rds_account" "default" {
  db_instance_id   = alicloud_db_instance.default.id
  account_name     = var.rds_config.account_name
  account_password = var.rds_config.account_password
}

resource "alicloud_db_database" "default" {
  instance_id = alicloud_db_instance.default.id
  name        = var.rds_config.database_name
}

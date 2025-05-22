provider "alicloud" {
  region = "cn-beijing"
}

module "complete" {
  source = "../.."
  vpc_config = {
    cidr_block = "192.168.0.0/16"
  }

  zone_ids = ["cn-beijing-l", "cn-beijing-f"]

  vswitches_config = {
    alb = ["192.168.1.0/24", "192.168.2.0/24"],
    ecs = ["192.168.3.0/24", "192.168.4.0/24"],
    rds = ["192.168.5.0/24", "192.168.6.0/24"],
  }

  rds_config = {
    account_name     = "tf_example"
    account_password = "Example1234"
    database_name    = "tf_example"
  }
}

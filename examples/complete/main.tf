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

  rds_config = var.rds_config
}

locals {
  prepare_data_script = <<-SHELL
    #!/bin/bash

    yum install -y mysql

    mkdir /data
    cat <<"EOF" >> /data/script.sql
    -- script.sql
    USE ${var.rds_config.database_name};
    CREATE TABLE `todo_list` (
    `id` bigint NOT NULL COMMENT 'id',
    `title` varchar(128) NOT NULL COMMENT 'title',
    `desc` text NOT NULL COMMENT 'description',
    `status` varchar(128) NOT NULL COMMENT 'status 未开始、进行中、已完成、已取消',
    `priority` varchar(128) NOT NULL COMMENT 'priority 高、中、低',
    `expect_time` datetime COMMENT 'expect time',
    `actual_completion_time` datetime COMMENT 'actual completion time',
    `gmt_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'modified time',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
    ;
    INSERT INTO todo_list
    (id, title, `desc`, `status`, priority, expect_time)
    value(1,  "创建一个应用", "使用阿里云解决方案搭建一个应用", "进行中", "高", "2024-04-01 00:00:00")
    EOF

    mysql -h${module.complete.rds_instance_connection_string} -u${var.rds_config.account_name} -p${var.rds_config.account_password} < /data/script.sql
    SHELL

  install_app_script = <<-SHELL
    #!/bin/bash
    sudo yum -y install java-1.8.0-openjdk-devel.x86_64

    cat <<EOT >> ~/.bash_profile
    export APPLETS_RDS_ENDPOINT=${module.complete.rds_instance_connection_string}
    export APPLETS_RDS_USER=${var.rds_config.account_name}
    export APPLETS_RDS_PASSWORD=${var.rds_config.account_password}
    export APPLETS_RDS_DB_NAME=${var.rds_config.database_name}
    export APP_MANUAL_DEPLOY=false
    EOT
    source ~/.bash_profile
    wget https://help-static-aliyun-doc.aliyuncs.com/tech-solution/cloud-demo-0.0.2.jar
    nohup java -jar cloud-demo-0.0.2.jar > demo.log 2>&1 &
    SHELL
}

resource "alicloud_ecs_command" "prepare_data" {
  name            = "prepare_data"
  command_content = base64encode(local.prepare_data_script)
  description     = "create tables"
  type            = "RunShellScript"
  working_dir     = "/root"
}

resource "alicloud_ecs_invocation" "invoke_script" {
  instance_id = [module.complete.ecs_instance_ids[0]]
  command_id  = alicloud_ecs_command.prepare_data.id
  depends_on  = [module.complete]
}


resource "alicloud_ecs_command" "install_app" {
  depends_on      = [alicloud_ecs_invocation.invoke_script]
  name            = "install_app"
  command_content = base64encode(local.install_app_script)
  type            = "RunShellScript"
  working_dir     = "/root"
}

resource "alicloud_ecs_invocation" "invoke_app" {
  instance_id = module.complete.ecs_instance_ids
  command_id  = alicloud_ecs_command.install_app.id
}

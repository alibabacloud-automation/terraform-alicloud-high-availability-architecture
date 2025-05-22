Terraform module to build high availability architecture for Alibaba Cloud

terraform-alicloud-high-availability-architecture
======================================

[English](https://github.com/alibabacloud-automation/terraform-alicloud-high-availability-architecture/blob/main/README.md) | 简体中文

本方案从企业上云最基础的需求出发，面向可能遇到的单点故障风险，介绍了“业务上云高可用架构”方案设计。Module 架构采用单地域双可用区部署，将业务系统、数据库部署在2个不同可用区，实现了可用区级故障灾备能力，从而保证了业务的连续性。同时，该架构还利用专有网络VPC、交换机和跨可用区安全组等基础设施，实现了私有网络下的系统通信。

架构图:

![image](https://raw.githubusercontent.com/alibabacloud-automation/terraform-alicloud-high-availability-architecture/main/scripts/diagram.png)



## 用法


```hcl
provider "alicloud" {
  region = "cn-beijing"
}

module "complete" {
  source = "alibabacloud-automation/high-availability-architecture/alicloud"
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
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-high-availability-architecture/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_alb_load_balancer.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/alb_load_balancer) | resource |
| [alicloud_db_database.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_instance.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_rds_account.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/rds_account) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.sg_rule_http](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.sg_rule_https](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.alb](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.ecs](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.rds](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_load_balancer_config"></a> [alb\_load\_balancer\_config](#input\_alb\_load\_balancer\_config) | The parameters used to create alb load balancer. | <pre>object({<br>    address_type           = optional(string, "Internet")<br>    address_allocated_mode = optional(string, "Fixed")<br>    pay_type               = optional(string, "PayAsYouGo")<br>    load_balancer_edition  = optional(string, "Basic")<br>  })</pre> | `{}` | no |
| <a name="input_ecs_config"></a> [ecs\_config](#input\_ecs\_config) | The parameters of instance. | <pre>object({<br>    image_id                   = optional(string, "aliyun_3_9_x64_20G_alibase_20231219.vhd")<br>    instance_name              = optional(string, null)<br>    description                = optional(string, null)<br>    instance_charge_type       = optional(string, "PostPaid")<br>    instance_type              = optional(string, "ecs.e-c1m2.large")<br>    system_disk_category       = optional(string, "cloud_essd_entry")<br>    password                   = optional(string, null)<br>    internet_max_bandwidth_out = optional(number, 100)<br>    internet_charge_type       = optional(string, "PayByTraffic")<br>  })</pre> | `{}` | no |
| <a name="input_rds_config"></a> [rds\_config](#input\_rds\_config) | The parameters of rds. | <pre>object({<br>    engine                   = optional(string, "MySQL")<br>    engine_version           = optional(string, "8.0")<br>    instance_type            = optional(string, "mysql.x2.medium.2c")<br>    instance_storage         = optional(number, 20)<br>    instance_charge_type     = optional(string, "Postpaid")<br>    monitoring_period        = optional(string, "60")<br>    db_instance_storage_type = optional(string, "cloud_essd")<br>    instance_name            = optional(string, null)<br><br>    account_name     = string<br>    account_password = string<br><br>    database_name = string<br>  })</pre> | n/a | yes |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | The name of security group. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags of the resource. | `map(string)` | `{}` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | The parameters of vpc. | <pre>object({<br>    cidr_block = string<br>    vpc_name   = optional(string, null)<br>  })</pre> | n/a | yes |
| <a name="input_vswitches_config"></a> [vswitches\_config](#input\_vswitches\_config) | The parameters of vswitches. | `map(list(string))` | n/a | yes |
| <a name="input_zone_ids"></a> [zone\_ids](#input\_zone\_ids) | The zone ID of vSwitches. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_load_balancer_id"></a> [alb\_load\_balancer\_id](#output\_alb\_load\_balancer\_id) | The ID of the ALB Load Balancer |
| <a name="output_alb_vswitch_ids"></a> [alb\_vswitch\_ids](#output\_alb\_vswitch\_ids) | The IDs of the ALB VSwitches |
| <a name="output_ecs_instance_ids"></a> [ecs\_instance\_ids](#output\_ecs\_instance\_ids) | The IDs of the ECS Instances |
| <a name="output_ecs_vswitch_ids"></a> [ecs\_vswitch\_ids](#output\_ecs\_vswitch\_ids) | The IDs of the ECS VSwitches |
| <a name="output_rds_instance_id"></a> [rds\_instance\_id](#output\_rds\_instance\_id) | The ID of the RDS Instance |
| <a name="output_rds_vswitch_ids"></a> [rds\_vswitch\_ids](#output\_rds\_vswitch\_ids) | The IDs of the RDS VSwitches |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the Security Group |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->

## 提交问题

如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

## 作者

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## 许可

MIT Licensed. See LICENSE for full details.

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)


# Complete

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_complete"></a> [complete](#module\_complete) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_ecs_command.install_app](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_command.prepare_data](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invoke_app](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_ecs_invocation.invoke_script](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ecs_invocation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_rds_config"></a> [rds\_config](#input\_rds\_config) | The parameters of rds. | <pre>object({<br>    # instance<br>    engine                   = optional(string, "MySQL")<br>    engine_version           = optional(string, "8.0")<br>    instance_type            = optional(string, "mysql.x2.medium.2c")<br>    instance_storage         = optional(number, 20)<br>    instance_charge_type     = optional(string, "Postpaid")<br>    monitoring_period        = optional(string, "60")<br>    db_instance_storage_type = optional(string, "cloud_essd")<br>    instance_name            = optional(string, null)<br>    # account<br>    account_name     = string<br>    account_password = string<br>    account_type     = optional(string, null)<br>    # database<br>    database_name = string<br>    character_set = optional(string, null)<br>  })</pre> | <pre>{<br>  "account_name": "tf_example",<br>  "account_password": "Example1234",<br>  "account_type": "Super",<br>  "character_set": "utf8mb4",<br>  "database_name": "tf_example"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_WebUrl"></a> [WebUrl](#output\_WebUrl) | The Addresses of Web. |
| <a name="output_alb_load_balancer_id"></a> [alb\_load\_balancer\_id](#output\_alb\_load\_balancer\_id) | The ID of the ALB Load Balancer |
| <a name="output_alb_vswitch_ids"></a> [alb\_vswitch\_ids](#output\_alb\_vswitch\_ids) | The IDs of the ALB VSwitches |
| <a name="output_ecs_instance_ids"></a> [ecs\_instance\_ids](#output\_ecs\_instance\_ids) | The IDs of the ECS Instances |
| <a name="output_ecs_vswitch_ids"></a> [ecs\_vswitch\_ids](#output\_ecs\_vswitch\_ids) | The IDs of the ECS VSwitches |
| <a name="output_rds_instance_connection_string"></a> [rds\_instance\_connection\_string](#output\_rds\_instance\_connection\_string) | The connection string of the RDS Instance |
| <a name="output_rds_instance_id"></a> [rds\_instance\_id](#output\_rds\_instance\_id) | The ID of the RDS Instance |
| <a name="output_rds_vswitch_ids"></a> [rds\_vswitch\_ids](#output\_rds\_vswitch\_ids) | The IDs of the RDS VSwitches |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the Security Group |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->

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

No resources.

## Inputs

No inputs.

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
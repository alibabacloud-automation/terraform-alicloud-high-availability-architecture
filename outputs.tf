output "vpc_id" {
  description = "The ID of the VPC"
  value       = alicloud_vpc.default.id
}

output "alb_vswitch_ids" {
  description = "The IDs of the ALB VSwitches"
  value       = { for k, v in alicloud_vswitch.alb : k => v.id }
}

output "ecs_vswitch_ids" {
  description = "The IDs of the ECS VSwitches"
  value       = { for k, v in alicloud_vswitch.ecs : k => v.id }
}

output "rds_vswitch_ids" {
  description = "The IDs of the RDS VSwitches"
  value       = { for k, v in alicloud_vswitch.rds : k => v.id }
}

output "alb_load_balancer_id" {
  description = "The ID of the ALB Load Balancer"
  value       = alicloud_alb_load_balancer.default.id
}

output "security_group_id" {
  description = "The ID of the Security Group"
  value       = alicloud_security_group.default.id
}

output "ecs_instance_ids" {
  description = "The IDs of the ECS Instances"
  value       = { for k, v in alicloud_instance.default : k => v.id }
}

output "rds_instance_id" {
  description = "The ID of the RDS Instance"
  value       = alicloud_db_instance.default.id
}

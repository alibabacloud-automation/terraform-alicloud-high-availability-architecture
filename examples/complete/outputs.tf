output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.complete.vpc_id
}

output "alb_vswitch_ids" {
  description = "The IDs of the ALB VSwitches"
  value       = module.complete.alb_vswitch_ids
}

output "ecs_vswitch_ids" {
  description = "The IDs of the ECS VSwitches"
  value       = module.complete.ecs_vswitch_ids
}

output "rds_vswitch_ids" {
  description = "The IDs of the RDS VSwitches"
  value       = module.complete.rds_vswitch_ids
}

output "alb_load_balancer_id" {
  description = "The ID of the ALB Load Balancer"
  value       = module.complete.alb_load_balancer_id
}

output "security_group_id" {
  description = "The ID of the Security Group"
  value       = module.complete.security_group_id
}

output "ecs_instance_ids" {
  description = "The IDs of the ECS Instances"
  value       = module.complete.ecs_instance_ids
}

output "rds_instance_id" {
  description = "The ID of the RDS Instance"
  value       = module.complete.rds_instance_id
}

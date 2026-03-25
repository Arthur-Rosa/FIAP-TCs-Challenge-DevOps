output "rds_auth_endpoint" {
  description = "RDS auth-db endpoint"
  value       = aws_db_instance.auth.endpoint
}

output "rds_flags_endpoint" {
  description = "RDS flags-db endpoint"
  value       = aws_db_instance.flags.endpoint
}

output "rds_targeting_endpoint" {
  description = "RDS targeting-db endpoint"
  value       = aws_db_instance.targeting.endpoint
}

output "redis_primary_endpoint" {
  description = "ElastiCache Redis primary endpoint"
  value       = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "redis_reader_endpoint" {
  description = "ElastiCache Redis reader endpoint"
  value       = aws_elasticache_replication_group.redis.reader_endpoint_address
}

output "dynamodb_table_name" {
  description = "DynamoDB analytics table name"
  value       = aws_dynamodb_table.analytics_events.name
}

output "dynamodb_table_arn" {
  description = "DynamoDB analytics table ARN"
  value       = aws_dynamodb_table.analytics_events.arn
}

output "rds_security_group_id" {
  description = "RDS security group ID"
  value       = aws_security_group.rds.id
}

output "redis_security_group_id" {
  description = "Redis security group ID"
  value       = aws_security_group.redis.id
}

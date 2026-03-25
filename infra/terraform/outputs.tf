output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.networking.private_subnet_ids
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_oidc_issuer" {
  description = "EKS cluster OIDC issuer URL"
  value       = module.eks.cluster_oidc_issuer
}

output "rds_auth_endpoint" {
  description = "RDS auth-db endpoint"
  value       = module.databases.rds_auth_endpoint
}

output "rds_flags_endpoint" {
  description = "RDS flags-db endpoint"
  value       = module.databases.rds_flags_endpoint
}

output "rds_targeting_endpoint" {
  description = "RDS targeting-db endpoint"
  value       = module.databases.rds_targeting_endpoint
}

output "redis_primary_endpoint" {
  description = "ElastiCache Redis primary endpoint"
  value       = module.databases.redis_primary_endpoint
}

output "dynamodb_table_name" {
  description = "DynamoDB analytics table name"
  value       = module.databases.dynamodb_table_name
}

output "sqs_queue_url" {
  description = "SQS queue URL"
  value       = module.messaging.sqs_queue_url
}

output "sqs_queue_arn" {
  description = "SQS queue ARN"
  value       = module.messaging.sqs_queue_arn
}

output "ecr_repository_urls" {
  description = "ECR repository URLs"
  value       = module.ecr.repository_urls
}

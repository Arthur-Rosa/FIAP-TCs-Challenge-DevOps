variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used as prefix for all resources"
  type        = string
  default     = "feature-flags"
}

variable "environment" {
  description = "Environment (production, staging, development)"
  type        = string
  default     = "production"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "eksc-challenge-fiap"
}

variable "eks_cluster_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.30"
}

variable "node_instance_type" {
  description = "EC2 instance type for EKS nodes"
  type        = string
  default     = "t3.medium"
}

variable "node_min_size" {
  description = "Minimum number of nodes in each node group"
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of nodes in each node group"
  type        = number
  default     = 4
}

variable "node_desired_size" {
  description = "Desired number of nodes in each node group"
  type        = number
  default     = 2
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_engine_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "15.4"
}

variable "auth_db_password" {
  description = "Password for auth_db RDS instance"
  type        = string
  sensitive   = true
}

variable "flags_db_password" {
  description = "Password for flags_db RDS instance"
  type        = string
  sensitive   = true
}

variable "targeting_db_password" {
  description = "Password for targeting_db RDS instance"
  type        = string
  sensitive   = true
}

variable "redis_node_type" {
  description = "ElastiCache node type"
  type        = string
  default     = "cache.t3.medium"
}

variable "ecr_image_tag_mutability" {
  description = "ECR image tag mutability (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "MUTABLE"
}

variable "ecr_scan_on_push" {
  description = "Enable ECR image scanning on push"
  type        = bool
  default     = true
}

variable "sqs_queue_name" {
  description = "Name of the SQS queue"
  type        = string
  default     = "evaluation-service-sqs"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for analytics events"
  type        = string
  default     = "feature-flags-analytics-events"
}

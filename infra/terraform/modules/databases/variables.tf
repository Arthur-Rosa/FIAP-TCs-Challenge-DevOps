variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "db_instance_class" {
  type = string
}

variable "db_engine_version" {
  type = string
}

variable "auth_db_password" {
  type      = string
  sensitive = true
}

variable "flags_db_password" {
  type      = string
  sensitive = true
}

variable "targeting_db_password" {
  type      = string
  sensitive = true
}

variable "redis_node_type" {
  type = string
}

variable "dynamodb_table_name" {
  type = string
}

variable "eks_security_group_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

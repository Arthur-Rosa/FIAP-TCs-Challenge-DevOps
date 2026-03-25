locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

module "networking" {
  source = "./modules/networking"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  eks_cluster_name     = var.eks_cluster_name
  tags                 = local.common_tags
}

module "eks" {
  source = "./modules/eks"

  project_name        = var.project_name
  environment         = var.environment
  cluster_name        = var.eks_cluster_name
  cluster_version     = var.eks_cluster_version
  vpc_id              = module.networking.vpc_id
  private_subnet_ids  = module.networking.private_subnet_ids
  node_instance_type  = var.node_instance_type
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
  node_desired_size   = var.node_desired_size
  tags                = local.common_tags

  depends_on = [module.networking]
}

module "databases" {
  source = "./modules/databases"

  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.networking.vpc_id
  private_subnet_ids    = module.networking.private_subnet_ids
  db_instance_class     = var.db_instance_class
  db_engine_version     = var.db_engine_version
  auth_db_password      = var.auth_db_password
  flags_db_password     = var.flags_db_password
  targeting_db_password = var.targeting_db_password
  redis_node_type       = var.redis_node_type
  dynamodb_table_name   = var.dynamodb_table_name
  eks_security_group_id = module.eks.node_security_group_id
  tags                  = local.common_tags

  depends_on = [module.networking, module.eks]
}

module "messaging" {
  source = "./modules/messaging"

  project_name   = var.project_name
  environment    = var.environment
  sqs_queue_name = var.sqs_queue_name
  tags           = local.common_tags
}

module "ecr" {
  source = "./modules/ecr"

  project_name             = var.project_name
  environment              = var.environment
  image_tag_mutability     = var.ecr_image_tag_mutability
  scan_on_push             = var.ecr_scan_on_push
  tags                     = local.common_tags
}

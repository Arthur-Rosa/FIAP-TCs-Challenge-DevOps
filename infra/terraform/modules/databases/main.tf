# ─── RDS Subnet Group ─────────────────────────────────────────────────────────
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.tags, {
    Name = "${var.project_name}-db-subnet-group"
  })
}

# ─── Security Group for RDS ───────────────────────────────────────────────────
resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Security group for RDS PostgreSQL instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from EKS nodes"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.eks_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-rds-sg"
  })
}

# ─── RDS: Auth Database ───────────────────────────────────────────────────────
resource "aws_db_instance" "auth" {
  identifier     = "${var.project_name}-auth-db"
  engine         = "postgres"
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class

  db_name  = "auth_db"
  username = "auth_user"
  password = var.auth_db_password

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp3"
  storage_encrypted     = true

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  multi_az               = false
  publicly_accessible    = false

  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:04:00-Mon:05:00"

  deletion_protection       = false
  skip_final_snapshot       = false
  final_snapshot_identifier = "${var.project_name}-auth-db-final-snapshot"

  tags = merge(var.tags, {
    Name    = "${var.project_name}-auth-db"
    Service = "auth-service"
  })
}

# ─── RDS: Flags Database ──────────────────────────────────────────────────────
resource "aws_db_instance" "flags" {
  identifier     = "${var.project_name}-flag-db"
  engine         = "postgres"
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class

  db_name  = "flags_db"
  username = "flags_user"
  password = var.flags_db_password

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp3"
  storage_encrypted     = true

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  multi_az               = false
  publicly_accessible    = false

  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:04:00-Mon:05:00"

  deletion_protection       = false
  skip_final_snapshot       = false
  final_snapshot_identifier = "${var.project_name}-flag-db-final-snapshot"

  tags = merge(var.tags, {
    Name    = "${var.project_name}-flag-db"
    Service = "flag-service"
  })
}

# ─── RDS: Targeting Database ──────────────────────────────────────────────────
resource "aws_db_instance" "targeting" {
  identifier     = "${var.project_name}-targeting-db"
  engine         = "postgres"
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class

  db_name  = "targeting_db"
  username = "targeting_user"
  password = var.targeting_db_password

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp3"
  storage_encrypted     = true

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  multi_az               = false
  publicly_accessible    = false

  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:04:00-Mon:05:00"

  deletion_protection       = false
  skip_final_snapshot       = false
  final_snapshot_identifier = "${var.project_name}-targeting-db-final-snapshot"

  tags = merge(var.tags, {
    Name    = "${var.project_name}-targeting-db"
    Service = "targeting-service"
  })
}

# ─── ElastiCache: Redis ───────────────────────────────────────────────────────
resource "aws_elasticache_subnet_group" "main" {
  name       = "${var.project_name}-redis-subnet-group-tf"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.tags, {
    Name = "${var.project_name}-redis-subnet-group-tf"
  })
}

resource "aws_security_group" "redis" {
  name        = "${var.project_name}-redis-sg"
  description = "Security group for ElastiCache Redis"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Redis from EKS nodes"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [var.eks_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-redis-sg"
  })
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id = "${var.project_name}-redis-cluster"
  description          = "Redis cluster for feature flags evaluation caching"

  node_type            = var.redis_node_type
  num_cache_clusters   = 2
  parameter_group_name = "default.redis7"
  engine_version       = "7.1"
  port                 = 6379

  subnet_group_name  = aws_elasticache_subnet_group.main.name
  security_group_ids = [aws_security_group.redis.id]

  at_rest_encryption_enabled = true
  transit_encryption_enabled = false

  automatic_failover_enabled = true
  multi_az_enabled           = true

  maintenance_window       = "sun:05:00-sun:06:00"
  snapshot_window          = "04:00-05:00"
  snapshot_retention_limit = 3

  tags = merge(var.tags, {
    Name    = "${var.project_name}-redis-cluster"
    Service = "evaluation-service"
  })
}

# ─── DynamoDB: Analytics Events ───────────────────────────────────────────────
resource "aws_dynamodb_table" "analytics_events" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "event_id"

  attribute {
    name = "event_id"
    type = "S"
  }

  ttl {
    attribute_name = "expires_at"
    enabled        = true
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  tags = merge(var.tags, {
    Name    = var.dynamodb_table_name
    Service = "analytics-service"
  })
}

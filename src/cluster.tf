resource "aws_rds_cluster" "main" {
  engine      = "aurora-mysql"
  engine_mode = "provisioned"

  ## Database
  cluster_identifier = var.md_metadata.name_prefix
  # TODO: param
  allow_major_version_upgrade = true

  master_username = local.has_source_snapshot ? null : random_pet.root_username[0].id
  master_password = random_password.root_password.result

  # TODO: param
  apply_immediately   = true
  engine_version      = var.database.version
  deletion_protection = var.database.deletion_protection
  snapshot_identifier = lookup(var.database, "source_snapshot", null)

  ## Networking
  db_subnet_group_name   = aws_db_subnet_group.main.name
  port                   = local.mysql.port
  vpc_security_group_ids = [aws_security_group.main.id]
  network_type           = "IPV4"

  ## Storage
  storage_encrypted = true
  kms_key_id        = data.aws_kms_alias.mysql.target_key_arn

  ## Backups & Snapshots
  skip_final_snapshot       = var.backup.skip_final_snapshot
  final_snapshot_identifier = var.backup.skip_final_snapshot ? null : local.final_snapshot_identifier
  backup_retention_period   = var.backup.retention_period
  copy_tags_to_snapshot     = true

  ## Observability
  enabled_cloudwatch_logs_exports = var.observability.enabled_cloudwatch_logs_exports

  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.main.name

  # This originally used a dynamic block to set the scaling or exclude the block if not instance type serverless,
  #   but when switching instance types terraform would get confused still requiring min_capacity & max_capacity even though
  #   it was no longer "serverless"
  #
  # This sets the serverless values no matter what, defaulting to minimums. The instance type
  #   still controls whether its serverless or not.
  serverlessv2_scaling_configuration {
    min_capacity = local.serverless_scaling.min_capacity
    max_capacity = local.serverless_scaling.max_capacity
  }
}

# # https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Reference.ParameterGroups.html

# # log_bin_trust_function_creators=1
# # lower_case_table_names=1

resource "aws_rds_cluster_parameter_group" "main" {
  name        = var.md_metadata.name_prefix
  family      = local.parameter_group_family
  description = "Aurora MySQL Cluster Parameter Group for ${var.md_metadata.name_prefix}"

  # Apply cluster parameters dynamically
  dynamic "parameter" {
    for_each = var.parameter_groups.cluster_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
}

resource "aws_db_parameter_group" "main" {
  name        = var.md_metadata.name_prefix
  family      = local.parameter_group_family
  description = "Aurora MySQL Instance Parameter Group for ${var.md_metadata.name_prefix}"

  dynamic "parameter" {
    for_each = var.parameter_groups.instance_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
}

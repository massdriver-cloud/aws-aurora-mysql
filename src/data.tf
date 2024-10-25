data "aws_caller_identity" "current" {}

data "aws_kms_alias" "mysql" {
  name = "alias/${var.md_metadata.name_prefix}-mysql-encryption"
}

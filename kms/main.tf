data "aws_caller_identity" "current" {}

resource "aws_kms_key" "mysql" {
  description             = "Encryption Key for Aurora MySQL ${var.md_metadata.name_prefix}"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms.json
}

resource "aws_kms_alias" "mysql" {
  name          = "alias/${var.md_metadata.name_prefix}-mysql-encryption"
  target_key_id = aws_kms_key.mysql.key_id
}

data "aws_iam_policy_document" "kms" {
  statement {
    sid = "Enable IAM User Permissions"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
  }
}

resource "aws_db_subnet_group" "main" {
  name        = var.md_metadata.name_prefix
  description = "Aurora MySQL ${var.md_metadata.name_prefix}"
  subnet_ids  = local.subnet_ids[var.networking.subnet_type]
}

resource "aws_security_group" "main" {
  vpc_id      = local.vpc_id
  name_prefix = "${var.md_metadata.name_prefix}-"
  description = "Control traffic to/from Aurora MySQL ${var.md_metadata.name_prefix}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "vpc_ingress" {
  count       = 1
  description = "From allowed CIDRs"
  type        = "ingress"
  from_port   = local.mysql.port
  to_port     = local.mysql.port
  protocol    = local.mysql.protocol
  cidr_blocks = [var.vpc.data.infrastructure.cidr]

  security_group_id = aws_security_group.main.id
}

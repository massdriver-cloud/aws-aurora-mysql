locals {
  writer_data_authentication = {
    username = aws_rds_cluster.main.master_username
    password = aws_rds_cluster.main.master_password
    hostname = aws_rds_cluster.main.endpoint
    port     = local.mysql.port
  }

  readers_data_authentication = {
    username = aws_rds_cluster.main.master_username
    password = aws_rds_cluster.main.master_password
    hostname = aws_rds_cluster.main.reader_endpoint
    port     = local.mysql.port
  }

  data_infrastructure = {
    arn = aws_rds_cluster.main.arn
  }

  data_security = {
    network = {
      mysql = {
        arn      = aws_security_group.main.arn
        port     = local.mysql.port
        protocol = local.mysql.protocol
      }
    }
  }

  rdbms_specs = {
    engine         = "MySQL"
    engine_version = aws_rds_cluster.main.engine_version
    version        = aws_rds_cluster.main.engine_version_actual
  }
}

resource "massdriver_artifact" "writer" {
  field    = "writer"
  name     = "MySQL Primary (writer): ${aws_rds_cluster.main.arn}"
  artifact = jsonencode(
    {
      data = {
        infrastructure = local.data_infrastructure
        authentication = local.writer_data_authentication
        security       = local.data_security
      }
      specs = {
        rdbms = local.rdbms_specs
      }
    }
  )
}

resource "massdriver_artifact" "readers" {
  field                = "readers"
  provider_resource_id = aws_rds_cluster.main.arn
  name                 = "MySQL Replicas (reader): ${aws_rds_cluster.main.arn}"
  artifact = jsonencode(
    {
      data = {
        infrastructure = local.data_infrastructure
        authentication = local.readers_data_authentication
        security       = local.data_security
      }
      specs = {
        rdbms = local.rdbms_specs
      }
    }
  )
}

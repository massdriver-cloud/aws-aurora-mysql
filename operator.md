### AWS Aurora MySQL

Amazon Aurora MySQL is a MySQL-compatible, relational database service with enhanced performance, scalability, and availability features. It automates time-consuming tasks like hardware provisioning, database setup, patching, and backups. Aurora is fault-tolerant and prioritizes durability with multiple layers of security.

### Design Decisions

1. **Separate Modules for Each Database Type**: We maintain distinct modules for each database type (e.g., PostgreSQL, MySQL) to provide specialized configurations and ensure robust performance for the specific use case.
   
2. **Parameter Groups**: Custom MySQL parameter groups are employed to fine-tune database settings and optimize performance.
   
3. **Replication**: Aurora MySQL replication is enabled by default for high availability and automatic failover to enhance reliability and reduce downtime.
   
4. **Security**: VPC, subnets, and security groups are configured to ensure secure access to Aurora MySQL instances. The module also supports encryption at rest and in transit.
   
5. **Monitoring**: CloudWatch is set up to track key metrics such as CPU utilization, read/write operations, and memory usage.

### Runbook

#### Database Connection Issues

If users are experiencing trouble connecting to the Aurora MySQL database, one of the initial steps is to verify connectivity and security settings.

To check if the necessary security group rules are in place:

```sh
aws ec2 describe-security-groups --group-ids <security-group-id>
```

Ensure the security group allows inbound traffic on port 3306, which is the default port for MySQL.

#### Slow Query Performance

If the MySQL queries are running slower than expected, identify slow queries using the MySQL slow query log.

Enable the slow query log and set the threshold:

```mysql
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1; -- Time in seconds
```

Review the slow query log to identify problematic queries:

```mysql
SELECT * FROM mysql.slow_log ORDER BY query_time DESC;
```

Optimizing these queries can improve overall performance. 

#### High CPU Utilization

Monitor the CPU usage of your Aurora MySQL instance via AWS CLI:

```sh
aws cloudwatch get-metric-statistics \
    --namespace AWS/RDS \
    --metric-name CPUUtilization \
    --dimensions Name=DBInstanceIdentifier,Value=<your-db-instance-identifier> \
    --start-time 2023-05-01T00:00:00Z \
    --end-time 2023-05-01T23:59:59Z \
    --period 300 \
    --statistics Average
```

For in-depth analysis, you might want to look into the active processes and queries consuming CPU resources:

```mysql
SHOW PROCESSLIST;
```

This will list all running threads which can help identify the cause of high CPU usage.

#### Memory Issues

Check for large memory consumption by monitoring the CloudWatch metrics for FreeableMemory:

```sh
aws cloudwatch get-metric-statistics \
    --namespace AWS/RDS \
    --metric-name FreeableMemory \
    --dimensions Name=DBInstanceIdentifier,Value=<your-db-instance-identifier> \
    --start-time 2023-05-01T00:00:00Z \
    --end-time 2023-05-01T23:59:59Z \
    --period 300 \
    --statistics Average
```

Investigate and manage the MySQL buffers to better optimize memory usage:

```mysql
SHOW VARIABLES LIKE 'innodb_buffer_pool_size';
SHOW STATUS LIKE 'Innodb_buffer_pool_pages_dirty';
```

Adjust the buffer pool size if necessary, based on your instance's available memory.

#### Backup and Restore Issues

To troubleshoot backup and restore issues, first ensure that automated backups are enabled and configured correctly:

```sh
aws rds describe-db-instances --db-instance-identifier <your-db-instance-identifier>
```

To manually create a backup:

```sh
aws rds create-db-snapshot --db-instance-identifier <your-db-instance-identifier> --db-snapshot-identifier <your-snapshot-id>
```

Restore a database from a snapshot:

```sh
aws rds restore-db-instance-from-db-snapshot --db-instance-identifier <new-db-instance-identifier> --db-snapshot-identifier <your-snapshot-id>
```


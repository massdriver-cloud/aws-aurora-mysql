## AWS Aurora MySQL

Amazon Aurora MySQL is a MySQL-compatible, relational database that offers the performance and availability of high-end commercial databases at a lower cost. It provides features such as replication, automated backups, and high availability.

### Design Decisions

- **Database Engine**: Uses Aurora MySQL to ensure MySQL compatibility and leverage Aurora's performance and scalability benefits.
- **High Availability**: Configured with multiple AZs (Availability Zones) for high availability and automatic failover.
- **Storage Auto-scaling**: Enabled to dynamically adjust storage allocation as the database grows.
- **Backup**: Automated backups and snapshots are enabled to provide point-in-time recovery.
- **VPC Isolation**: Deployed within a specified VPC to ensure network isolation and security.

### Runbook

#### Instance Connectivity Issues

If you are unable to connect to your Aurora MySQL instance, you can check the endpoint and port settings.

```sh
aws rds describe-db-instances --db-instance-identifier <your-db-instance-identifier>
```

Ensure that the `Endpoint` and `Port` values are correctly configured.

#### Slow Query Performance

Identify long-running queries using the MySQL slow query log.

```sql
SHOW VARIABLES LIKE 'slow_query_log';
SET GLOBAL slow_query_log = 'ON';
SHOW VARIABLES LIKE 'slow_query_log_file';
# Assuming slow query log file is '/rdsdbdata/log/slowquery/mysql-slowquery.log'
```

Review the slow query log file to analyze which queries are causing the performance issues.

```sh
sudo tail -f /rdsdbdata/log/slowquery/mysql-slowquery.log
```

#### Aurora Instance Status

Check the status of the Aurora instance to confirm it's available.

```sh
aws rds describe-db-clusters --db-cluster-identifier <your-db-cluster-identifier>
```

Example output:
```json
{
  "DBClusters": [
    {
      "Status": "available",
      ...
    }
  ]
}
```

Ensure the `Status` is `available`.

#### Disk Space Usage

Monitoring the disk space usage of your Aurora MySQL instance.

```sh
aws cloudwatch get-metric-statistics --namespace AWS/RDS --metric-name FreeStorageSpace --dimensions Name=DBInstanceIdentifier,Value=<your-db-instance-identifier> --start-time $(date -u -d'-1 day' +%Y-%m-%dT%H:%M:%SZ) --end-time $(date -u +%Y-%m-%dT%H:%M:%SZ) --period 3600 --statistics Average
```

Review the `Average` value to ensure your database is not running out of space.

#### Replication Issues

Check replication status within your Aurora MySQL instance.

```sql
SHOW SLAVE STATUS\G;
```

Key fields to examine:

- `Slave_IO_Running`
- `Slave_SQL_Running`
- `Seconds_Behind_Master`

For any issues, `Slave_IO_Running` and `Slave_SQL_Running` should both be `Yes`. If not, further investigation into error logs will be necessary.

#### Backup and Restore

To check the latest backup status:

```sh
aws rds describe-db-snapshots --db-instance-identifier <your-db-instance-identifier> --snapshot-type automated
```

To restore from the latest backup:

```sh
aws rds restore-db-cluster-from-snapshot --db-cluster-identifier <new-db-cluster-identifier> --snapshot-identifier <latest-snapshot-identifier>
```

#### High CPU Usage

If your instance exhibits high CPU usage, identify the queries causing high CPU load.

```sql
SHOW PROCESSLIST;
```

Look for queries in the `state` column with `Copying to tmp table`, `Sorting result`, etc., and optimize them for better performance.


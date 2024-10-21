# AWS Aurora MySQL Runbook

Amazon Aurora is a fully managed relational database engine that's compatible with MySQL. This runbook will guide you through connecting to your Aurora MySQL cluster, troubleshooting common issues, and monitoring your database's performance.

## Connecting to Your Database

### Connect via AWS CLI
Check the status and endpoint of your Aurora MySQL cluster:

```sh
aws rds describe-db-clusters --query "DBClusters[?DBClusterIdentifier=='<cluster_identifier>'].[Status, Endpoint, ReaderEndpoint]" --output table
```

> Expect to see the status of the cluster along with the primary and reader endpoints.

### Connect via MySQL CLI
Use the following command to connect to your MySQL database:

```sh
mysql -h <host> -u <username> -p<password> -D <database>
```

Replace `<host>`, `<username>`, `<password>`, and `<database>` with your database's details.

## Troubleshooting Common Issues

### Connection Issues

1. **Check Cluster Status**: Use the AWS CLI to check the cluster's status and ensure it is available:
   
   ```sh
   aws rds describe-db-clusters --query "DBClusters[?DBClusterIdentifier=='<cluster_identifier>'].[Status, Endpoint, ReaderEndpoint]" --output table
   ```

2. **Verify Security Groups**: Ensure that the correct ingress rules are configured in the security group:

   ```sh
   aws ec2 describe-security-groups --group-ids <security_group_id> --query "SecurityGroups[*].[GroupId, IpPermissions]" --output table
   ```

3. **Monitor Active Connections**: Use MySQL commands to check active connections and sessions:

   ```sql
   SHOW PROCESSLIST;
   ```

   This command will show active queries and connections to help you diagnose issues related to connection overload.

### High Latency or Slow Queries

1. **Identify Slow Queries**: Use the following MySQL command to identify long-running queries:

   ```sql
   SHOW FULL PROCESSLIST;
   ```

   This will display all running queries and their status, helping you identify slow or stuck queries.

2. **Enable Slow Query Logging**: Enable and review the slow query log to track problematic queries:

   ```sql
   SET GLOBAL slow_query_log = 'ON';
   SET GLOBAL long_query_time = 1;  -- Logs queries taking more than 1 second
   ```

   To view logged slow queries:

   ```sh
   tail -f /var/log/mysql/mysql-slow.log
   ```

### Deadlock & Blocking Issues

1. **Check for Deadlocks**: Use the following command to identify deadlocks in MySQL:

   ```sql
   SHOW ENGINE INNODB STATUS;
   ```

   This will display the most recent deadlock along with related information.

2. **Identify Blocking Queries**: Use this query to identify queries blocking other queries:

   ```sql
   SELECT r.trx_id waiting_trx_id, r.trx_mysql_thread_id waiting_thread, r.trx_query waiting_query, b.trx_id blocking_trx_id, b.trx_mysql_thread_id blocking_thread, b.trx_query blocking_query
   FROM information_schema.innodb_lock_waits w
   JOIN information_schema.innodb_trx b ON b.trx_id = w.blocking_trx_id
   JOIN information_schema.innodb_trx r ON r.trx_id = w.requesting_trx_id;
   ```

## Monitoring & Backup Management

### Backup Verification

1. **List Snapshots**: Use this AWS CLI command to check for available snapshots:

   ```sh
   aws rds describe-db-cluster-snapshots --db-cluster-identifier <cluster_identifier> --query "DBClusterSnapshots[].[DBClusterSnapshotIdentifier, SnapshotCreateTime]" --output table
   ```

2. **Verify Retention Policy**: Check your backup retention settings to ensure backups are kept as per your policy:

   ```sh
   aws rds describe-db-clusters --db-cluster-identifier <cluster_identifier> --query "DBClusters[0].[BackupRetentionPeriod]" --output table
   ```

### Disk Space Usage

1. **Monitor Free Storage Space**: Use CloudWatch to monitor disk space usage for your Aurora MySQL cluster:

   ```sh
   aws cloudwatch get-metric-statistics --namespace "AWS/RDS" --metric-name "FreeStorageSpace" --dimensions Name=DBClusterIdentifier,Value=<cluster_identifier> --statistics Average --period 300 --start-time $(date -u -d '1 hour ago' +"%Y-%m-%dT%H:%M:%SZ") --end-time $(date -u +"%Y-%m-%dT%H:%M:%SZ")
   ```

2. **Reclaim Disk Space**: Reclaim disk space by optimizing and defragmenting tables in MySQL:

   ```sql
   OPTIMIZE TABLE <table_name>;
   ```

   This will help reduce table fragmentation and free up unused space.

### Monitor Storage Usage by Tables

Use this query to check the disk usage for each table in your database:

```sql
SELECT table_name AS "Table", ROUND(((data_length + index_length) / 1024 / 1024), 2) AS "Size (MB)"
FROM information_schema.TABLES
WHERE table_schema = '<database_name>'
ORDER BY (data_length + index_length) DESC;
```

## Advanced Monitoring

### Check Replication Status

Ensure that your Aurora MySQL cluster's replication is healthy by running this query:

```sql
SHOW SLAVE STATUS\G;
```

This will display detailed replication information, including any replication lag.

### Monitor Binary Log Activity

Track binary log activity to understand how frequently transactions are being written to the binary log:

```sql
SHOW BINARY LOGS;
```

This command will display a list of binary logs that MySQL uses for replication and recovery.

---

## Additional Resources

- [AWS Aurora MySQL User Guide](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.AuroraMySQL.html)
- [AWS Aurora User Guide](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Overview.html)
- [MySQL Documentation](https://dev.mysql.com/doc/)

---

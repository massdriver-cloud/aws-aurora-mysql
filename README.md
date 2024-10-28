[![Massdriver][logo]][website]

# aws-aurora-mysql

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]


Amazon Aurora is a fully managed relational database engine that's compatible with MySQL. Aurora includes a high-performance storage subsystem. Its MySQL-compatible database engines are customized to take advantage of that fast distributed storage. The underlying storage grows automatically as needed. An Aurora cluster volume can grow to a maximum size of 128 tebibytes (TiB). Aurora also automates and standardizes database clustering and replication, which are typically among the most challenging aspects of database configuration and administration.


---

## Design

For detailed information, check out our [Operator Guide](operator.md) for this bundle.

## Usage

Our bundles aren't intended to be used locally, outside of testing. Instead, our bundles are designed to be configured, connected, deployed and monitored in the [Massdriver][website] platform.

### What are Bundles?

Bundles are the basic building blocks of infrastructure, applications, and architectures in [Massdriver][website]. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Bundle

### Params

Form input parameters for configuring a bundle for deployment.

<details>
<summary>View</summary>

<!-- PARAMS:START -->
## Properties

- **`availability`** *(object)*
  - **`autoscaling_mode`** *(string)*: Default: `DISABLED`.
    - **One of**
      - Disabled
      - Database Connections
      - CPU Utilization
  - **`min_replicas`** *(integer)*: Replicas and primary are automatically spread across AWS zones. Minimum: `0`. Maximum: `15`. Default: `0`.
- **`backup`** *(object)*
  - **`retention_period`** *(integer)*: The days to retain backups for. Minimum: `1`. Maximum: `35`. Default: `7`.
  - **`skip_final_snapshot`** *(boolean)*: Determines whether a final DB snapshot is created before the DB cluster is deleted. If true is specified, no DB snapshot is created. Default: `False`.
- **`database`** *(object)*
  - **`ca_cert_identifier`** *(string)*: The identifier of the CA certificate for the DB instances. [Learn more](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html). Default: `rds-ca-rsa2048-g1`.
    - **One of**
      - RSA 2048
      - RSA 4096
      - ECC 384
  - **`deletion_protection`** *(boolean)*: Explicitly requires this field to be unset before allowing deletion. Default: `True`.
  - **`source_snapshot`** *(string)*: Cluster or database snapshot ARN. Specifies whether or not to **create** this cluster from a snapshot. Aurora clusters can be restored from cluster snapshots *or* database snapshots. [Learn more](https://docs.massdriver.cloud/runbook/aws/migrating-rds-databases).

    Examples:
    ```json
    "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
    ```

    ```json
    "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
    ```

  - **`version`** *(string)*: Default: `8.0.mysql_aurora.3.07.1`.
    - **One of**
      - Aurora (MySQL 5.7) 2.11.1
      - Aurora (MySQL 5.7) 2.11.2
      - Aurora (MySQL 5.7) 2.11.3
      - Aurora (MySQL 5.7) 2.11.4
      - Aurora MySQL (compatible with MySQL 5.7.2.11.4)
      - Aurora (MySQL 5.7) 2.11.5
      - Aurora (MySQL 5.7) 2.11.6
      - Aurora MySQL 2.12.0 (compatible with MySQL 5.7.40)
      - Aurora MySQL 2.12.1 (compatible with MySQL 5.7.40)
      - Aurora MySQL 2.12.2 (compatible with MySQL 5.7.44)
      - Aurora MySQL 2.12.3 (compatible with MySQL 5.7.44)
      - Aurora MySQL 2.12.4 (compatible with MySQL 5.7.44)
      - Aurora MySQL 3.04.0 (compatible with MySQL 8.0.28)
      - Aurora MySQL 3.04.1 (compatible with MySQL 8.0.28)
      - Aurora MySQL 3.04.2 (compatible with MySQL 8.0.28)
      - Aurora MySQL 3.04.3 (compatible with MySQL 8.0.28)
      - Aurora MySQL 3.05.2 (compatible with MySQL 8.0.32)
      - Aurora MySQL 3.06.0 (compatible with MySQL 8.0.34)
      - Aurora MySQL 3.06.1 (compatible with MySQL 8.0.34)
      - Aurora MySQL 3.07.0 (compatible with MySQL 8.0.36)
      - Aurora MySQL 3.07.1 (compatible with MySQL 8.0.36)
- **`networking`** *(object)*
  - **`subnet_type`** *(string)*: Deploy to internal subnets (cannot reach the internet) or private subnets (internet egress traffic allowed). Must be one of: `['internal', 'private']`. Default: `internal`.
- **`observability`** *(object)*
  - **`enabled_cloudwatch_logs_exports`** *(array)*: Export logs to Cloudwatch for auditing and monitoring.
    - **Items**: Must be one of: `['audit', 'error', 'general', 'slowquery']`.
  - **`enhanced_monitoring_interval`** *(integer)*: Monitor the operating system of DB instances in real time. Enhanced Monitoring is stored in Cloudwatch Logs and may incur additional changes. [Learn more](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.html). Default: `0`.
    - **One of**
      - Disabled
      - 1 second
      - 5 seconds
      - 10 seconds
      - 15 seconds
      - 30 seconds
      - 60 seconds
  - **`performance_insights_retention_period`** *(integer)*: Performance Insights is a database performance tuning and monitoring feature that helps you quickly assess the load on your database, and determine when and where to take action. Performance Insights allows non-experts to detect performance problems with an easy-to-understand dashboard that visualizes database load. Default: `0`.
    - **One of**
      - Disabled
      - 1 Week
      - 1 Month
      - 3 Months
      - 6 Months
      - 1 Year
      - 2 Years
- **`parameter_groups`** *(object)*
  - **`cluster_parameters`** *(array)*: Configures settings that apply to the entire Aurora cluster, affecting all instances, such as replication and logging configurations.
    - **Items** *(object)*
      - **`apply_method`** *(string)*: When to apply the parameter changes. Must be one of: `['pending-reboot', 'immediate']`. Default: `pending-reboot`.
      - **`name`** *(string)*: Must be one of: `['aurora_binlog_read_buffer_size', 'aurora_binlog_replication_max_yield_seconds', 'aurora_binlog_replication_sec_index_parallel_workers', 'aurora_binlog_use_large_read_buffer', 'aurora_disable_hash_join', 'aurora_enable_repl_bin_log_filtering', 'aurora_enable_replica_log_compression', 'aurora_enable_staggered_replica_restart', 'aurora_enable_zdr', 'aurora_enhanced_binlog', 'aurora_jemalloc_background_thread', 'aurora_jemalloc_dirty_decay_ms', 'aurora_jemalloc_tcache_enabled', 'aurora_load_from_s3_role', 'aurora_mask_password_hashes_type', 'aurora_select_into_s3_role', 'authentication_kerberos_caseins_cmp', 'auto_increment_increment', 'auto_increment_offset', 'aws_default_lambda_role', 'aws_default_s3_role', 'binlog_backup', 'binlog_checksum', 'binlog_format', 'binlog_group_commit_sync_delay', 'binlog_group_commit_sync_no_delay_count', 'binlog_replication_globaldb', 'binlog_row_metadata', 'binlog_row_value_options', 'binlog_rows_query_log_events', 'binlog_transaction_compression', 'binlog_transaction_compression_level_zstd', 'binlog_transaction_dependency_history_size', 'binlog_transaction_dependency_tracking', 'binlog-do-db', 'binlog-ignore-db', 'character_set_client', 'character_set_connection', 'character_set_database', 'character_set_filesystem', 'character_set_results', 'character_set_server', 'character-set-client-handshake', 'collation_connection', 'collation_server', 'completion_type', 'enforce_gtid_consistency', 'event_scheduler', 'gtid-mode', 'information_schema_stats_expiry', 'init_connect', 'innodb_adaptive_hash_index', 'innodb_aurora_instant_alter_column_allowed', 'innodb_autoinc_lock_mode', 'innodb_cmp_per_index_enabled', 'innodb_commit_concurrency', 'innodb_deadlock_detect', 'innodb_default_row_format', 'innodb_file_per_table', 'innodb_flush_log_at_trx_commit', 'innodb_ft_max_token_size', 'innodb_ft_min_token_size', 'innodb_ft_num_word_optimize', 'innodb_ft_sort_pll_degree', 'innodb_online_alter_log_max_size', 'innodb_optimize_fulltext_only', 'innodb_print_all_deadlocks', 'innodb_purge_batch_size', 'innodb_purge_threads', 'innodb_rollback_on_timeout', 'innodb_rollback_segments', 'innodb_spin_wait_delay', 'innodb_stats_include_delete_marked', 'innodb_strict_mode', 'innodb_support_xa', 'innodb_sync_array_size', 'innodb_sync_spin_loops', 'innodb_table_locks', 'innodb_trx_commit_allow_data_loss', 'internal_tmp_disk_storage_engine', 'internal_tmp_mem_storage_engine', 'key_buffer_size', 'lc_time_names', 'log_error_suppression_list', 'low_priority_updates', 'lower_case_table_names', 'master_verify_checksum', 'master-info-repository', 'max_delayed_threads', 'max_error_count', 'max_execution_time', 'min_examined_row_limit', 'preload_buffer_size', 'query_cache_type', 'read_only', 'relay-log-space-limit', 'replica_parallel_type', 'replica_preserve_commit_order', 'replica_transaction_retries', 'replica_type_conversions', 'replicate-do-db', 'replicate-do-table', 'replicate-ignore-db', 'replicate-ignore-table', 'replicate-wild-do-table', 'replicate-wild-ignore-table', 'require_secure_transport', 'rpl_read_size', 'server_audit_events', 'server_audit_excl_users', 'server_audit_incl_users', 'server_audit_logging', 'server_audit_logs_upload', 'skip-character-set-client-handshake', 'slave-skip-errors', 'source_verify_checksum', 'sync_frm', 'thread_cache_size', 'time_zone', 'tls_version']`.
      - **`value`** *(string)*
  - **`instance_parameters`** *(array)*: Configures settings that apply to each instance within the cluster, such as memory, cache, and connection limits.
    - **Items** *(object)*
      - **`apply_method`** *(string)*: When to apply the parameter changes. Must be one of: `['pending-reboot', 'immediate']`. Default: `pending-reboot`.
      - **`name`** *(string)*: Must be one of: `['activate_all_roles_on_login', 'aurora_disable_hash_join', 'aurora_lab_mode', 'aurora_oom_response', 'aurora_parallel_query', 'aurora_pq', 'aurora_read_replica_read_committed', 'aurora_tmptable_enable_per_table_limit', 'aurora_use_vector_instructions', 'autocommit', 'automatic_sp_privileges', 'back_log', 'binlog_cache_size', 'binlog_max_flush_queue_time', 'binlog_order_commits', 'binlog_stmt_cache_size', 'binlog_transaction_compression', 'binlog_transaction_compression_level_zstd', 'bulk_insert_buffer_size', 'concurrent_insert', 'connect_timeout', 'default_tmp_storage_engine', 'default_week_format', 'delay_key_write', 'delayed_insert_limit', 'delayed_insert_timeout', 'delayed_queue_size', 'div_precision_increment', 'end_markers_in_json', 'eq_range_index_dive_limit', 'event_scheduler', 'explicit_defaults_for_timestamp', 'flush_time', 'ft_max_word_len', 'ft_min_word_len', 'ft_query_expansion_limit', 'ft_stopword_file', 'general_log', 'group_concat_max_len', 'host_cache_size', 'init_connect', 'innodb_adaptive_hash_index', 'innodb_adaptive_max_sleep_delay', 'innodb_aurora_max_partitions_for_range', 'innodb_autoextend_increment', 'innodb_buffer_pool_size', 'innodb_compression_failure_threshold_pct', 'innodb_compression_level', 'innodb_compression_pad_pct_max', 'innodb_concurrency_tickets', 'innodb_deadlock_detect', 'innodb_file_format', 'innodb_ft_aux_table', 'innodb_ft_cache_size', 'innodb_ft_enable_stopword', 'innodb_ft_server_stopword_table', 'innodb_ft_user_stopword_table', 'innodb_large_prefix', 'innodb_lock_wait_timeout', 'innodb_lru_scan_depth', 'innodb_max_purge_lag', 'innodb_max_purge_lag_delay', 'innodb_monitor_disable', 'innodb_monitor_enable', 'innodb_monitor_reset', 'innodb_monitor_reset_all', 'innodb_old_blocks_pct', 'innodb_old_blocks_time', 'innodb_open_files', 'innodb_print_all_deadlocks', 'innodb_random_read_ahead', 'innodb_read_ahead_threshold', 'innodb_replication_delay', 'innodb_sort_buffer_size', 'innodb_stats_auto_recalc', 'innodb_stats_method', 'innodb_stats_on_metadata', 'innodb_stats_persistent', 'innodb_stats_persistent_sample_pages', 'innodb_stats_transient_sample_pages', 'innodb_thread_sleep_delay', 'interactive_timeout', 'internal_tmp_disk_storage_engine', 'internal_tmp_mem_storage_engine', 'join_buffer_size', 'keep_files_on_create', 'key_buffer_size', 'key_cache_age_threshold', 'key_cache_block_size', 'key_cache_division_limit', 'local_infile', 'lock_wait_timeout', 'log_bin_trust_function_creators', 'log_bin_use_v1_row_events', 'log_error_suppression_list', 'log_output', 'log_queries_not_using_indexes', 'log_throttle_queries_not_using_indexes', 'log_warnings', 'long_query_time', 'low_priority_updates', 'max_allowed_packet', 'max_binlog_cache_size', 'max_binlog_stmt_cache_size', 'max_connect_errors', 'max_connections', 'max_delayed_threads', 'max_error_count', 'max_execution_time', 'max_heap_table_size', 'max_insert_delayed_threads', 'max_join_size', 'max_length_for_sort_data', 'max_prepared_stmt_count', 'max_seeks_for_key', 'max_sort_length', 'max_sp_recursion_depth', 'max_tmp_tables', 'max_user_connections', 'max_write_lock_count', 'metadata_locks_cache_size', 'min_examined_row_limit', 'myisam_data_pointer_size', 'myisam_max_sort_file_size', 'myisam_mmap_size', 'myisam_sort_buffer_size', 'myisam_stats_method', 'myisam_use_mmap', 'net_buffer_length', 'net_read_timeout', 'net_retry_count', 'net_write_timeout', 'old_passwords', 'old-style-user-limits', 'optimizer_prune_level', 'optimizer_search_depth', 'optimizer_switch', 'optimizer_trace', 'optimizer_trace_features', 'optimizer_trace_limit', 'optimizer_trace_max_mem_size', 'optimizer_trace_offset', 'performance_schema', 'performance_schema_accounts_size', 'performance_schema_consumer_events_stages_current', 'performance_schema_consumer_events_stages_history', 'performance_schema_consumer_events_stages_history_long', 'performance_schema_consumer_events_statements_current', 'performance_schema_consumer_events_statements_history', 'performance_schema_consumer_events_statements_history_long', 'performance_schema_consumer_events_waits_history', 'performance_schema_consumer_events_waits_history_long', 'performance_schema_consumer_global_instrumentation', 'performance_schema_consumer_statements_digest', 'performance_schema_consumer_thread_instrumentation', 'performance_schema_digests_size', 'performance_schema_events_stages_history_long_size', 'performance_schema_events_stages_history_size', 'performance_schema_events_statements_history_long_size', 'performance_schema_events_statements_history_size', 'performance_schema_events_transactions_history_long_size', 'performance_schema_events_transactions_history_size', 'performance_schema_events_waits_history_long_size', 'performance_schema_events_waits_history_size', 'performance_schema_hosts_size', 'performance_schema_max_cond_classes', 'performance_schema_max_cond_instances', 'performance_schema_max_digest_length', 'performance_schema_max_file_classes', 'performance_schema_max_file_handles', 'performance_schema_max_file_instances', 'performance_schema_max_index_stat', 'performance_schema_max_memory_classes', 'performance_schema_max_metadata_locks', 'performance_schema_max_mutex_classes', 'performance_schema_max_mutex_instances', 'performance_schema_max_prepared_statements_instances', 'performance_schema_max_program_instances', 'performance_schema_max_rwlock_classes', 'performance_schema_max_rwlock_instances', 'performance_schema_max_socket_classes', 'performance_schema_max_socket_instances', 'performance_schema_max_sql_text_length', 'performance_schema_max_stage_classes', 'performance_schema_max_statement_classes', 'performance_schema_max_statement_stack', 'performance_schema_max_table_handles', 'performance_schema_max_table_instances', 'performance_schema_max_table_lock_stat', 'performance_schema_max_thread_classes', 'performance_schema_max_thread_instances', 'performance_schema_session_connect_attrs_size', 'performance_schema_setup_actors_size', 'performance_schema_setup_objects_size', 'performance_schema_show_processlist', 'performance_schema_users_size', 'performance-schema-consumer-events-waits-current', 'performance-schema-instrument', 'preload_buffer_size', 'profiling_history_size', 'query_alloc_block_size', 'query_cache_limit', 'query_cache_min_res_unit', 'query_cache_size', 'query_cache_type', 'query_cache_wlock_invalidate', 'query_prealloc_size', 'range_alloc_block_size', 'read_buffer_size', 'read_only', 'read_rnd_buffer_size', 'relay_log_info_repository', 'replica_checkpoint_group', 'replica_checkpoint_period', 'replica_parallel_workers', 'replica_pending_jobs_size_max', 'replica_skip_errors', 'replica_sql_verify_checksum', 'safe-user-create', 'secure_auth', 'show_create_table_verbosity', 'skip_show_database', 'slave_checkpoint_group', 'slave_checkpoint_period', 'slave_parallel_workers', 'slave_pending_jobs_size_max', 'slave_sql_verify_checksum', 'slow_launch_time', 'slow_query_log', 'sort_buffer_size', 'sql_mode', 'sql_select_limit', 'stored_program_cache', 'sync_master_info', 'sync_relay_log', 'sync_relay_log_info', 'sync_source_info', 'sysdate-is-now', 'table_definition_cache', 'table_open_cache', 'table_open_cache_instances', 'temp-pool', 'temptable_max_mmap', 'temptable_max_ram', 'temptable_use_mmap', 'thread_cache_size', 'thread_stack', 'timed_mutexes', 'tmp_table_size', 'transaction_alloc_block_size', 'transaction_isolation', 'transaction_prealloc_size', 'tx_isolation', 'updatable_views_with_limit', 'wait_timeout']`.
      - **`value`** *(string)*
## Examples

  ```json
  {
      "__name": "Development",
      "availability": {
          "min_replicas": 0
      },
      "backup": {
          "retention_period": 1,
          "skip_final_snapshot": true
      },
      "database": {
          "deletion_protection": false,
          "instance_class": "db.t4g.medium"
      },
      "networking": {
          "subnet_type": "internal"
      },
      "observability": {
          "enabled_cloudwatch_logs_exports": [],
          "enhanced_monitoring_interval": 0,
          "performance_insights_retention_period": 0
      }
  }
  ```

  ```json
  {
      "__name": "Production",
      "availability": {
          "min_replicas": 2
      },
      "backup": {
          "retention_period": 35,
          "skip_final_snapshot": false
      },
      "database": {
          "deletion_protection": true,
          "instance_class": "db.r6g.2xlarge"
      },
      "networking": {
          "subnet_type": "internal"
      },
      "observability": {
          "enabled_cloudwatch_logs_exports": [
              "audit",
              "error",
              "general",
              "slowquery"
          ],
          "enhanced_monitoring_interval": 60,
          "performance_insights_retention_period": 372
      }
  }
  ```

<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->
## Properties

- **`aws_authentication`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`arn`** *(string)*: Amazon Resource Name.

      Examples:
      ```json
      "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
      ```

      ```json
      "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
      ```

    - **`external_id`** *(string)*: An external ID is a piece of data that can be passed to the AssumeRole API of the Security Token Service (STS). You can then use the external ID in the condition element in a role's trust policy, allowing the role to be assumed only when a certain value is present in the external ID.
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

- **`vpc`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`infrastructure`** *(object)*
      - **`arn`** *(string)*: Amazon Resource Name.

        Examples:
        ```json
        "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
        ```

        ```json
        "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
        ```

      - **`cidr`** *(string)*

        Examples:
        ```json
        "10.100.0.0/16"
        ```

        ```json
        "192.24.12.0/22"
        ```

      - **`internal_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```


          Examples:
      - **`private_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```


          Examples:
      - **`public_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```


          Examples:
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->
## Properties

- **`readers`** *(object)*: Authentication parameters for a MySQL database. Cannot contain additional properties.
  - **`data`** *(object)*: Cannot contain additional properties.
    - **`authentication`** *(object)*
      - **`hostname`** *(string)*
      - **`password`** *(string)*
      - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
      - **`username`** *(string)*
    - **`infrastructure`** *(object)*: Cloud specific MySQL configuration data.
      - **One of**
        - AWS Infrastructure ARN*object*: Minimal AWS Infrastructure Config. Cannot contain additional properties.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

        - Azure Infrastructure Resource ID*object*: Minimal Azure Infrastructure Config. Cannot contain additional properties.
          - **`ari`** *(string)*: Azure Resource ID.

            Examples:
            ```json
            "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
            ```

        - GCP Infrastructure Name*object*: GCP Infrastructure Config For Resources With A Name Not A GRN. Cannot contain additional properties.
          - **`name`** *(string)*: Name Of GCP Resource.

            Examples:
            ```json
            "my-cloud-function"
            ```

            ```json
            "my-sql-instance"
            ```

    - **`security`** *(object)*: TBD.
      - **Any of**
        - AWS Security information*object*: Informs downstream services of network and/or IAM policies. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Policies. Cannot contain additional properties.
            - **`^[a-z]+[a-z_]*[a-z]+$`** *(object)*
              - **`policy_arn`** *(string)*: AWS IAM policy ARN.

                Examples:
                ```json
                "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                ```

                ```json
                "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                ```

          - **`identity`** *(object)*: For instances where IAM policies must be attached to a role attached to an AWS resource, for instance AWS Eventbridge to Firehose, this attribute should be used to allow the downstream to attach it's policies (Firehose) directly to the IAM role created by the upstream (Eventbridge). It is important to remember that connections in massdriver are one way, this scheme perserves the dependency relationship while allowing bundles to control the lifecycles of resources under it's management. Cannot contain additional properties.
            - **`role_arn`** *(string)*: ARN for this resources IAM Role.

              Examples:
              ```json
              "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
              ```

              ```json
              "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
              ```

          - **`network`** *(object)*: AWS security group rules to inform downstream services of ports to open for communication. Cannot contain additional properties.
            - **`^[a-z-]+$`** *(object)*
              - **`arn`** *(string)*: Amazon Resource Name.

                Examples:
                ```json
                "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                ```

                ```json
                "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                ```

              - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
              - **`protocol`** *(string)*: Must be one of: `['tcp', 'udp']`.
        - Security*object*: Azure Security Configuration. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Roles And Scopes. Cannot contain additional properties.
            - **`^[a-z]+[a-z_]*[a-z]$`** *(object)*
              - **`role`**: Azure Role.

                Examples:
                ```json
                "Storage Blob Data Reader"
                ```

              - **`scope`** *(string)*: Azure IAM Scope.
        - Security*object*: GCP Security Configuration. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Roles And Conditions. Cannot contain additional properties.
            - **`^[a-z]+[a-z_]*[a-z]$`** *(object)*
              - **`condition`** *(string)*: GCP IAM Condition.
              - **`role`**: GCP Role.

                Examples:
                ```json
                "roles/owner"
                ```

                ```json
                "roles/redis.editor"
                ```

                ```json
                "roles/storage.objectCreator"
                ```

                ```json
                "roles/storage.legacyObjectReader"
                ```

  - **`specs`** *(object)*: Cannot contain additional properties.
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

    - **`azure`** *(object)*: .
      - **`region`** *(string)*: Select the Azure region you'd like to provision your resources in.
    - **`gcp`** *(object)*: .
      - **`project`** *(string)*
      - **`region`** *(string)*: The GCP region to provision resources in.

        Examples:
        ```json
        "us-east1"
        ```

        ```json
        "us-east4"
        ```

        ```json
        "us-west1"
        ```

        ```json
        "us-west2"
        ```

        ```json
        "us-west3"
        ```

        ```json
        "us-west4"
        ```

        ```json
        "us-central1"
        ```

    - **`rdbms`** *(object)*: Common metadata for relational databases.
      - **`engine`** *(string)*: The type of database server.

        Examples:
        ```json
        "postgresql"
        ```

        ```json
        "mysql"
        ```

      - **`engine_version`** *(string)*: The cloud provider's database version.

        Examples:
        ```json
        "5.7.mysql_aurora.2.03.2"
        ```

      - **`version`** *(string)*: The database version. Default: ``.

        Examples:
        ```json
        "12.2"
        ```

        ```json
        "5.7"
        ```


      Examples:
      ```json
      {
          "engine": "postgresql",
          "engine_version": "10.14",
          "version": "10.14"
      }
      ```

      ```json
      {
          "engine": "mysql",
          "engine_version": "5.7.mysql_aurora.2.03.2",
          "version": "5.7"
      }
      ```

- **`writer`** *(object)*: Authentication parameters for a MySQL database. Cannot contain additional properties.
  - **`data`** *(object)*: Cannot contain additional properties.
    - **`authentication`** *(object)*
      - **`hostname`** *(string)*
      - **`password`** *(string)*
      - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
      - **`username`** *(string)*
    - **`infrastructure`** *(object)*: Cloud specific MySQL configuration data.
      - **One of**
        - AWS Infrastructure ARN*object*: Minimal AWS Infrastructure Config. Cannot contain additional properties.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

        - Azure Infrastructure Resource ID*object*: Minimal Azure Infrastructure Config. Cannot contain additional properties.
          - **`ari`** *(string)*: Azure Resource ID.

            Examples:
            ```json
            "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
            ```

        - GCP Infrastructure Name*object*: GCP Infrastructure Config For Resources With A Name Not A GRN. Cannot contain additional properties.
          - **`name`** *(string)*: Name Of GCP Resource.

            Examples:
            ```json
            "my-cloud-function"
            ```

            ```json
            "my-sql-instance"
            ```

    - **`security`** *(object)*: TBD.
      - **Any of**
        - AWS Security information*object*: Informs downstream services of network and/or IAM policies. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Policies. Cannot contain additional properties.
            - **`^[a-z]+[a-z_]*[a-z]+$`** *(object)*
              - **`policy_arn`** *(string)*: AWS IAM policy ARN.

                Examples:
                ```json
                "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                ```

                ```json
                "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                ```

          - **`identity`** *(object)*: For instances where IAM policies must be attached to a role attached to an AWS resource, for instance AWS Eventbridge to Firehose, this attribute should be used to allow the downstream to attach it's policies (Firehose) directly to the IAM role created by the upstream (Eventbridge). It is important to remember that connections in massdriver are one way, this scheme perserves the dependency relationship while allowing bundles to control the lifecycles of resources under it's management. Cannot contain additional properties.
            - **`role_arn`** *(string)*: ARN for this resources IAM Role.

              Examples:
              ```json
              "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
              ```

              ```json
              "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
              ```

          - **`network`** *(object)*: AWS security group rules to inform downstream services of ports to open for communication. Cannot contain additional properties.
            - **`^[a-z-]+$`** *(object)*
              - **`arn`** *(string)*: Amazon Resource Name.

                Examples:
                ```json
                "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                ```

                ```json
                "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                ```

              - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
              - **`protocol`** *(string)*: Must be one of: `['tcp', 'udp']`.
        - Security*object*: Azure Security Configuration. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Roles And Scopes. Cannot contain additional properties.
            - **`^[a-z]+[a-z_]*[a-z]$`** *(object)*
              - **`role`**: Azure Role.

                Examples:
                ```json
                "Storage Blob Data Reader"
                ```

              - **`scope`** *(string)*: Azure IAM Scope.
        - Security*object*: GCP Security Configuration. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Roles And Conditions. Cannot contain additional properties.
            - **`^[a-z]+[a-z_]*[a-z]$`** *(object)*
              - **`condition`** *(string)*: GCP IAM Condition.
              - **`role`**: GCP Role.

                Examples:
                ```json
                "roles/owner"
                ```

                ```json
                "roles/redis.editor"
                ```

                ```json
                "roles/storage.objectCreator"
                ```

                ```json
                "roles/storage.legacyObjectReader"
                ```

  - **`specs`** *(object)*: Cannot contain additional properties.
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

    - **`azure`** *(object)*: .
      - **`region`** *(string)*: Select the Azure region you'd like to provision your resources in.
    - **`gcp`** *(object)*: .
      - **`project`** *(string)*
      - **`region`** *(string)*: The GCP region to provision resources in.

        Examples:
        ```json
        "us-east1"
        ```

        ```json
        "us-east4"
        ```

        ```json
        "us-west1"
        ```

        ```json
        "us-west2"
        ```

        ```json
        "us-west3"
        ```

        ```json
        "us-west4"
        ```

        ```json
        "us-central1"
        ```

    - **`rdbms`** *(object)*: Common metadata for relational databases.
      - **`engine`** *(string)*: The type of database server.

        Examples:
        ```json
        "postgresql"
        ```

        ```json
        "mysql"
        ```

      - **`engine_version`** *(string)*: The cloud provider's database version.

        Examples:
        ```json
        "5.7.mysql_aurora.2.03.2"
        ```

      - **`version`** *(string)*: The database version. Default: ``.

        Examples:
        ```json
        "12.2"
        ```

        ```json
        "5.7"
        ```


      Examples:
      ```json
      {
          "engine": "postgresql",
          "engine_version": "10.14",
          "version": "10.14"
      }
      ```

      ```json
      {
          "engine": "mysql",
          "engine_version": "5.7.mysql_aurora.2.03.2",
          "version": "5.7"
      }
      ```

<!-- ARTIFACTS:END -->

</details>

## Contributing

<!-- CONTRIBUTING:START -->

### Bug Reports & Feature Requests

Did we miss something? Please [submit an issue](https://github.com/massdriver-cloud/aws-aurora-mysql/issues) to report any bugs or request additional features.

### Developing

**Note**: Massdriver bundles are intended to be tightly use-case scoped, intention-based, reusable pieces of IaC for use in the [Massdriver][website] platform. For this reason, major feature additions that broaden the scope of an existing bundle are likely to be rejected by the community.

Still want to get involved? First check out our [contribution guidelines](https://docs.massdriver.cloud/bundles/contributing).

### Fix or Fork

If your use-case isn't covered by this bundle, you can still get involved! Massdriver is designed to be an extensible platform. Fork this bundle, or [create your own bundle from scratch](https://docs.massdriver.cloud/bundles/development)!

<!-- CONTRIBUTING:END -->

## Connect

<!-- CONNECT:START -->

Questions? Concerns? Adulations? We'd love to hear from you!

Please connect with us!

[![Email][email_shield]][email_url]
[![GitHub][github_shield]][github_url]
[![LinkedIn][linkedin_shield]][linkedin_url]
[![Twitter][twitter_shield]][twitter_url]
[![YouTube][youtube_shield]][youtube_url]
[![Reddit][reddit_shield]][reddit_url]

<!-- markdownlint-disable -->

[logo]: https://raw.githubusercontent.com/massdriver-cloud/docs/main/static/img/logo-with-logotype-horizontal-400x110.svg
[docs]: https://docs.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=aws-aurora-mysql&utm_content=docs
[website]: https://www.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=aws-aurora-mysql&utm_content=website
[github]: https://github.com/massdriver-cloud?utm_source=github&utm_medium=readme&utm_campaign=aws-aurora-mysql&utm_content=github
[slack]: https://massdriverworkspace.slack.com/?utm_source=github&utm_medium=readme&utm_campaign=aws-aurora-mysql&utm_content=slack
[linkedin]: https://www.linkedin.com/company/massdriver/?utm_source=github&utm_medium=readme&utm_campaign=aws-aurora-mysql&utm_content=linkedin



[contributors_shield]: https://img.shields.io/github/contributors/massdriver-cloud/aws-aurora-mysql.svg?style=for-the-badge
[contributors_url]: https://github.com/massdriver-cloud/aws-aurora-mysql/graphs/contributors
[forks_shield]: https://img.shields.io/github/forks/massdriver-cloud/aws-aurora-mysql.svg?style=for-the-badge
[forks_url]: https://github.com/massdriver-cloud/aws-aurora-mysql/network/members
[stars_shield]: https://img.shields.io/github/stars/massdriver-cloud/aws-aurora-mysql.svg?style=for-the-badge
[stars_url]: https://github.com/massdriver-cloud/aws-aurora-mysql/stargazers
[issues_shield]: https://img.shields.io/github/issues/massdriver-cloud/aws-aurora-mysql.svg?style=for-the-badge
[issues_url]: https://github.com/massdriver-cloud/aws-aurora-mysql/issues
[release_url]: https://github.com/massdriver-cloud/aws-aurora-mysql/releases/latest
[release_shield]: https://img.shields.io/github/release/massdriver-cloud/aws-aurora-mysql.svg?style=for-the-badge
[license_shield]: https://img.shields.io/github/license/massdriver-cloud/aws-aurora-mysql.svg?style=for-the-badge
[license_url]: https://github.com/massdriver-cloud/aws-aurora-mysql/blob/main/LICENSE


[email_url]: mailto:support@massdriver.cloud
[email_shield]: https://img.shields.io/badge/email-Massdriver-black.svg?style=for-the-badge&logo=mail.ru&color=000000
[github_url]: mailto:support@massdriver.cloud
[github_shield]: https://img.shields.io/badge/follow-Github-black.svg?style=for-the-badge&logo=github&color=181717
[linkedin_url]: https://linkedin.com/in/massdriver-cloud
[linkedin_shield]: https://img.shields.io/badge/follow-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2
[twitter_url]: https://twitter.com/massdriver?utm_source=github&utm_medium=readme&utm_campaign=aws-aurora-mysql&utm_content=twitter
[twitter_shield]: https://img.shields.io/badge/follow-Twitter-black.svg?style=for-the-badge&logo=twitter&color=1DA1F2
[discourse_url]: https://community.massdriver.cloud?utm_source=github&utm_medium=readme&utm_campaign=aws-aurora-mysql&utm_content=discourse
[discourse_shield]: https://img.shields.io/badge/join-Discourse-black.svg?style=for-the-badge&logo=discourse&color=000000
[youtube_url]: https://www.youtube.com/channel/UCfj8P7MJcdlem2DJpvymtaQ
[youtube_shield]: https://img.shields.io/badge/subscribe-Youtube-black.svg?style=for-the-badge&logo=youtube&color=FF0000
[reddit_url]: https://www.reddit.com/r/massdriver
[reddit_shield]: https://img.shields.io/badge/subscribe-Reddit-black.svg?style=for-the-badge&logo=reddit&color=FF4500

<!-- markdownlint-restore -->

<!-- CONNECT:END -->

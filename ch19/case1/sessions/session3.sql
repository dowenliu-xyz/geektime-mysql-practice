SHOW PROCESSLIST ;
# State: Waiting for table metadata lock
# Info: /* ApplicationName=DataGrip 2024.2.2 */ SELECT * FROM t WHERE id = 1
SELECT * FROM sys.schema_table_lock_waits;
SELECT blocking_pid FROM sys.schema_table_lock_waits;
KILL 11;
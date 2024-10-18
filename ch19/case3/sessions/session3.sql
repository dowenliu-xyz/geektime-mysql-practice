SHOW PROCESSLIST ;
# 10,root,192.168.97.0:63935,test,Sleep,76,"",
# 11,root,192.168.97.0:63952,test,Query,4,statistics,/* ApplicationName=DataGrip 2024.2.2 */ SELECT * FROM t WHERE id = 1 LOCK IN SHARE MODE
# 12,root,192.168.97.0:64002,test,Query,0,init,/* ApplicationName=DataGrip 2024.2.2 */ SHOW PROCESSLIST
SELECT * FROM sys.innodb_lock_waits WHERE locked_table='`test`.`t`';
SELECT blocking_pid INTO @bid FROM sys.innodb_lock_waits WHERE locked_table='`test`.`t`';
KILL @bid;
SHOW PROCESSLIST ;
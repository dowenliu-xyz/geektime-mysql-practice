SHOW PROCESSLIST ;
# 10,root,192.168.97.0:52768,test,Sleep,14,"",
# 11,root,192.168.97.0:52772,test,Sleep,12,"",
# 12,root,192.168.97.0:52793,test,Query,0,init,/* ApplicationName=DataGrip 2024.2.2 */ SHOW PROCESSLIST
SELECT * FROM information_schema.innodb_trx;
# trx_mysql_thread_id: 10
KILL CONNECTION 11;
# 避免 kill 事务中的 sleep 线程
SHOW PROCESSLIST ;
# 10,root,192.168.97.0:63739,test,Query,103,User sleep,/* ApplicationName=DataGrip 2024.2.2 */ SELECT sleep(1) FROM t
# 12,root,192.168.97.0:63834,test,Query,71,Waiting for table flush,/* ApplicationName=DataGrip 2024.2.2 */ FLUSH TABLES t
# 13,root,192.168.97.0:63837,test,Query,32,Waiting for table flush,/* ApplicationName=DataGrip 2024.2.2 */ SELECT * FROM t WHERE id = 1
# 14,root,192.168.97.0:63847,test,Query,0,init,/* ApplicationName=DataGrip 2024.2.2 */ SHOW PROCESSLIST
KILL 10;
SHOW PROCESSLIST ;
# 12,root,192.168.97.0:63834,test,Sleep,6,"",
# 13,root,192.168.97.0:63837,test,Sleep,6,"",
# 14,root,192.168.97.0:63847,test,Query,0,init,/* ApplicationName=DataGrip 2024.2.2 */ SHOW PROCESSLIST
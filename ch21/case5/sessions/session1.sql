BEGIN ;
SELECT * FROM t WHERE id > 10 AND id <= 15 FOR UPDATE ;
SELECT trx_id, trx_mysql_thread_id FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = CONNECTION_ID();
# 2328,10
SELECT ENGINE_TRANSACTION_ID, INDEX_NAME, LOCK_TYPE, LOCK_MODE, LOCK_STATUS, LOCK_DATA
FROM performance_schema.data_locks
WHERE OBJECT_SCHEMA = 'test' AND OBJECT_NAME = 't';
# 2328,,TABLE,IX,GRANTED,
# 2328,PRIMARY,RECORD,X,GRANTED,15
# switch to session 2
SELECT ENGINE_TRANSACTION_ID, INDEX_NAME, LOCK_TYPE, LOCK_MODE, LOCK_STATUS, LOCK_DATA
FROM performance_schema.data_locks
WHERE OBJECT_SCHEMA = 'test' AND OBJECT_NAME = 't';
# 2328,,TABLE,IX,GRANTED,
# 2328,PRIMARY,RECORD,X,GRANTED,15
ROLLBACK ;
# 主键上的 bug 已经修复了
--
BEGIN ;
SELECT * FROM t WHERE u > 10 AND u <= 15 FOR UPDATE ;
SELECT trx_id, trx_mysql_thread_id FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = CONNECTION_ID();
# 2321,9
SELECT ENGINE_TRANSACTION_ID, INDEX_NAME, LOCK_TYPE, LOCK_MODE, LOCK_STATUS, LOCK_DATA
FROM performance_schema.data_locks
WHERE OBJECT_SCHEMA = 'test' AND OBJECT_NAME = 't';
# 2321,,TABLE,IX,GRANTED,
# 2321,u,RECORD,X,GRANTED,"15, 15"
# 2321,u,RECORD,X,GRANTED,"20, 20"
# 2321,PRIMARY,RECORD,"X,REC_NOT_GAP",GRANTED,15
# switch to session 2
SELECT ENGINE_TRANSACTION_ID, INDEX_NAME, LOCK_TYPE, LOCK_MODE, LOCK_STATUS, LOCK_DATA
FROM performance_schema.data_locks
WHERE OBJECT_SCHEMA = 'test' AND OBJECT_NAME = 't';
# 2323,,TABLE,IX,GRANTED,
# 2323,u,RECORD,"X,GAP,INSERT_INTENTION",WAITING,"20, 20"
# 2322,,TABLE,IX,GRANTED,
# 2322,u,RECORD,"X,REC_NOT_GAP",WAITING,"20, 20"
# 2321,,TABLE,IX,GRANTED,
# 2321,u,RECORD,X,GRANTED,"15, 15"
# 2321,u,RECORD,X,GRANTED,"20, 20"
# 2321,PRIMARY,RECORD,"X,REC_NOT_GAP",GRANTED,15
ROLLBACK ;
# 非主键唯一索引上的 bug 仍然存在: 8.0.39, 8.4.2, 9.0.1

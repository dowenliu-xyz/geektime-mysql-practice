BEGIN;
SELECT * FROM t WHERE id > 9 AND id < 12 ORDER BY id DESC FOR UPDATE;

SELECT trx_id, trx_mysql_thread_id FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = CONNECTION_ID();
# 2321,10
SELECT ENGINE_TRANSACTION_ID, INDEX_NAME, LOCK_TYPE, LOCK_MODE, LOCK_STATUS, LOCK_DATA
FROM performance_schema.data_locks
WHERE OBJECT_SCHEMA = 'test' AND OBJECT_NAME = 't';
# 2321,,TABLE,IX,GRANTED,
# 2321,PRIMARY,RECORD,"X,GAP",GRANTED,15
# 2321,PRIMARY,RECORD,X,GRANTED,5
# 2321,PRIMARY,RECORD,X,GRANTED,10
ROLLBACK ;
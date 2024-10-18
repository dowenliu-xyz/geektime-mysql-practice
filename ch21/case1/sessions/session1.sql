BEGIN ;
UPDATE t SET d = d + 1 WHERE id = 7;
# switch to session 2

SELECT trx_id, trx_mysql_thread_id FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = CONNECTION_ID();
# 2321,10
SELECT ENGINE_TRANSACTION_ID, INDEX_NAME, LOCK_TYPE, LOCK_MODE, LOCK_STATUS, LOCK_DATA
FROM performance_schema.data_locks
WHERE OBJECT_SCHEMA = 'test' AND OBJECT_NAME = 't';
# 2326,,TABLE,IX,GRANTED,
# 2326,PRIMARY,RECORD,"X,GAP,INSERT_INTENTION",WAITING,10
# 2321,,TABLE,IX,GRANTED,
# 2321,PRIMARY,RECORD,"X,GAP",GRANTED,10
SELECT REQUESTING_ENGINE_TRANSACTION_ID, BLOCKING_ENGINE_TRANSACTION_ID FROM performance_schema.data_lock_waits;
# 2326,2321
ROLLBACK ;
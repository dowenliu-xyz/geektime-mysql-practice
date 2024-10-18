BEGIN ;
SELECT id FROM t WHERE c = 10 LOCK IN SHARE MODE ;
SELECT trx_id, trx_mysql_thread_id FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = CONNECTION_ID();
# 562948059696344,11
SELECT ENGINE_TRANSACTION_ID, INDEX_NAME, LOCK_TYPE, LOCK_MODE, LOCK_STATUS, LOCK_DATA
FROM performance_schema.data_locks
WHERE OBJECT_SCHEMA = 'test' AND OBJECT_NAME = 't';
# 562948059696344,,TABLE,IS,GRANTED,
# 562948059696344,c,RECORD,S,GRANTED,"10, 10"
# 562948059696344,c,RECORD,"S,GAP",GRANTED,"15, 15"
# switch to session 2
SELECT ENGINE_TRANSACTION_ID, INDEX_NAME, LOCK_TYPE, LOCK_MODE, LOCK_STATUS, LOCK_DATA
FROM performance_schema.data_locks
WHERE OBJECT_SCHEMA = 'test' AND OBJECT_NAME = 't';
# 2321,,TABLE,IX,GRANTED,
# 2321,c,RECORD,X,WAITING,"10, 10" # 加锁总是加 Next-Key Lock，加 Next-Key Lock 是分两步，先加左侧的 GAP Lock，再加上 Recode Lock。这是在加 Recode Lock 时阻塞了。
# 562948059696344,,TABLE,IS,GRANTED,
# 562948059696344,c,RECORD,S,GRANTED,"10, 10"
# 562948059696344,c,RECORD,"S,GAP",GRANTED,"15, 15"
INSERT INTO t VALUES (8, 8, 8);
# unblock session 2 and cause it error with deadlock
# 这里也要加 ((5,5),(10,10)] 这个 Next-Key Lock，在第一步加 GAP Lock 时，发现死锁，把没有完成加锁的 session 2 终止了。
# 是不是因为 session 2 持有的锁更少，所以认为解锁 session 2 代价更小？
ROLLBACK ;

BEGIN ;
INSERT INTO t(c, d) (SELECT c + 1, d FROM t FORCE INDEX (c) ORDER BY c DESC LIMIT 1);
# 8.0 下执行
SELECT ENGINE_TRANSACTION_ID, INDEX_NAME, LOCK_TYPE, LOCK_MODE, LOCK_STATUS, LOCK_DATA
FROM performance_schema.data_locks
WHERE OBJECT_SCHEMA = 'test' AND OBJECT_NAME = 't';
# 会发现在 t.c 索引上加了 S 锁。8.0 下没有执行后续验证实验。
# 5.7 下执行
SELECT * FROM information_schema.INNODB_LOCKS;
SELECT * FROM information_schema.INNODB_LOCK_WAITS;
# 应该是已经加锁了，但没有查出来
# switch to session 2
SELECT * FROM information_schema.INNODB_LOCKS;
SELECT * FROM information_schema.INNODB_LOCK_WAITS;
# session 2 执行 insert block 后，可以查出 当前事务加一了 supremum S 锁，另一事务尝试加 supremum X 锁
ROLLBACK ;
# switch to session 2

# 5.7 下 binlog_format 在 ROW 和 STATEMENT 下的表现相同
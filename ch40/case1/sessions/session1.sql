SHOW VARIABLES LIKE '%binlog_format%';
# STATEMENT
BEGIN ;
INSERT INTO t2(c, d) SELECT c, d FROM t;
SELECT ENGINE_TRANSACTION_ID, INDEX_NAME, LOCK_TYPE, LOCK_MODE, LOCK_STATUS, LOCK_DATA
FROM performance_schema.data_locks
WHERE OBJECT_SCHEMA = 'test' AND OBJECT_NAME = 't';
# +---------------------+----------+---------+---------+-----------+----------------------+
# |ENGINE_TRANSACTION_ID|INDEX_NAME|LOCK_TYPE|LOCK_MODE|LOCK_STATUS|LOCK_DATA             |
# +---------------------+----------+---------+---------+-----------+----------------------+
# |2321                 |null      |TABLE    |IS       |GRANTED    |null                  |
# |2321                 |PRIMARY   |RECORD   |S        |GRANTED    |supremum pseudo-record|
# |2321                 |PRIMARY   |RECORD   |S        |GRANTED    |1                     |
# |2321                 |PRIMARY   |RECORD   |S        |GRANTED    |2                     |
# |2321                 |PRIMARY   |RECORD   |S        |GRANTED    |3                     |
# |2321                 |PRIMARY   |RECORD   |S        |GRANTED    |4                     |
# +---------------------+----------+---------+---------+-----------+----------------------+
# insert ... select 是当前读，会加 S 锁
# switch to session 2
ROLLBACK ;
# switch to session 2

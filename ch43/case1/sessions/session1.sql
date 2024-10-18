BEGIN ;
SELECT * FROM t WHERE ftime = '2017-5-1' FOR UPDATE ;
# switch to session 2
SELECT ENGINE_TRANSACTION_ID, INDEX_NAME, LOCK_TYPE, LOCK_MODE, LOCK_STATUS, LOCK_DATA, OBJECT_NAME, PARTITION_NAME
FROM performance_schema.data_locks
WHERE OBJECT_SCHEMA = 'test';
# +---------------------+----------+---------+------------------+-----------+----------------------+-----------+
# |ENGINE_TRANSACTION_ID|INDEX_NAME|LOCK_TYPE|LOCK_MODE         |LOCK_STATUS|LOCK_DATA             |OBJECT_NAME|
# +---------------------+----------+---------+------------------+-----------+----------------------+-----------+
# |2331                 |null      |TABLE    |IX                |GRANTED    |null                  |t          |
# |2331                 |ftime     |RECORD   |X,INSERT_INTENTION|WAITING    |supremum pseudo-record|t          |
# |2324                 |null      |TABLE    |IX                |GRANTED    |null                  |t          |
# |2324                 |ftime     |RECORD   |X                 |GRANTED    |supremum pseudo-record|t          |
# +---------------------+----------+---------+------------------+-----------+----------------------+-----------+
SHOW ENGINE INNODB STATUS;
# ...
# ---TRANSACTION 2331, ACTIVE 25 sec inserting
# mysql tables in use 1, locked 1
# LOCK WAIT 2 lock struct(s), heap size 1128, 1 row lock(s), undo log entries 1
# MySQL thread id 10, OS thread handle 281473259138816, query id 274 192.168.97.0 root update
# /* ApplicationName=DataGrip 2024.2.2 */ INSERT INTO t VALUES ('2017-12-1', 1)
# ------- TRX HAS BEEN WAITING 25 SEC FOR THIS LOCK TO BE GRANTED:
# RECORD LOCKS space id 3 page no 5 n bits 72 index ftime of table `test`.`t` /* Partition `p_2018` */ trx id 2331 lock_mode X insert intention waiting
# Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
#  0: len 8; hex 73757072656d756d; asc supremum;;
# ...

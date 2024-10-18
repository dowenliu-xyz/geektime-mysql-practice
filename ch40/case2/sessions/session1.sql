SET GLOBAL SLOW_QUERY_LOG = 'ON';
SET LONG_QUERY_TIME = 0;
SHOW VARIABLES LIKE '%SLOW_QUERY%';
SHOW VARIABLES LIKE '%LONG_QUERY%';
INSERT INTO t2(c, d) (SELECT c + 1, d FROM t FORCE INDEX (c) ORDER BY c DESC LIMIT 1);
# Rows_examined: 1
SHOW STATUS LIKE '%innodb_rows_read%';
INSERT INTO t(c, d) (SELECT c + 1, d FROM t FORCE INDEX (c) ORDER BY c DESC LIMIT 1);
# 5.7.43 Rows_examined: 5
# 8.0.39 Rows_examined: 1
SHOW STATUS LIKE '%innodb_rows_read%';
# 5.7.43: 差值为 4
# 8.0.39: 差值为 1
EXPLAIN INSERT INTO t(c, d) (SELECT c + 1, d FROM t FORCE INDEX (c) ORDER BY c DESC LIMIT 1);
# 5.7.43:
# +--+-----------+-----+----------+-----+-------------+----+-------+----+
# |id|select_type|table|partitions|type |possible_keys|key |key_len|ref |
# +--+-----------+-----+----------+-----+-------------+----+-------+----+
# |1 |INSERT     |t    |null      |ALL  |null         |null|null   |null|
# |1 |SIMPLE     |t    |null      |index|null         |c   |5      |null|
# +--+-----------+-----+----------+-----+-------------+----+-------+----+
# 8.0.39:
# +--+-----------+-----+----------+-----+-------------+----+-------+----+----+--------+------------------------------------+
# |id|select_type|table|partitions|type |possible_keys|key |key_len|ref |rows|filtered|Extra                               |
# +--+-----------+-----+----------+-----+-------------+----+-------+----+----+--------+------------------------------------+
# |1 |INSERT     |t    |null      |ALL  |null         |null|null   |null|null|null    |null                                |
# |1 |SIMPLE     |t    |null      |index|null         |c   |5      |null|1   |100     |Backward index scan; Using temporary|
# +--+-----------+-----+----------+-----+-------------+----+-------+----+----+--------+------------------------------------+

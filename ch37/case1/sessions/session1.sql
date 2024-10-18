EXPLAIN
(SELECT 1000 AS f) UNION (SELECT id FROM t1 ORDER BY id DESC LIMIT 2);
# +--+------------+----------+----------+-----+-------------+-------+-------+----+----+--------+--------------------------------+
# |id|select_type |table     |partitions|type |possible_keys|key    |key_len|ref |rows|filtered|Extra                           |
# +--+------------+----------+----------+-----+-------------+-------+-------+----+----+--------+--------------------------------+
# |1 |PRIMARY     |null      |null      |null |null         |null   |null   |null|null|null    |No tables used                  |
# |2 |UNION       |t1        |null      |index|null         |PRIMARY|4      |null|2   |100     |Backward index scan; Using index|
# |3 |UNION RESULT|<union1,2>|null      |ALL  |null         |null   |null   |null|null|null    |Using temporary                 |
# +--+------------+----------+----------+-----+-------------+-------+-------+----+----+--------+--------------------------------+
EXPLAIN
(SELECT 1000 AS f) UNION ALL (SELECT id FROM t1 ORDER BY id DESC LIMIT 2);
# +--+-----------+-----+----------+-----+-------------+-------+-------+----+----+--------+--------------------------------+
# |id|select_type|table|partitions|type |possible_keys|key    |key_len|ref |rows|filtered|Extra                           |
# +--+-----------+-----+----------+-----+-------------+-------+-------+----+----+--------+--------------------------------+
# |1 |PRIMARY    |null |null      |null |null         |null   |null   |null|null|null    |No tables used                  |
# |2 |UNION      |t1   |null      |index|null         |PRIMARY|4      |null|2   |100     |Backward index scan; Using index|
# +--+-----------+-----+----------+-----+-------------+-------+-------+----+----+--------+--------------------------------+
EXPLAIN
SELECT id%10 AS m, count(*) AS c FROM t1 GROUP BY m;
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+----------------------------+
# |id|select_type|table|partitions|type |possible_keys|key|key_len|ref |rows|filtered|Extra                       |
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+----------------------------+
# |1 |SIMPLE     |t1   |null      |index|PRIMARY,a    |a  |5      |null|5   |100     |Using index; Using temporary|
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+----------------------------+
# 1,2,...,9,0
EXPLAIN
SELECT id%10 AS m, count(*) AS c FROM t1 GROUP BY m ORDER BY NULL;
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+----------------------------+
# |id|select_type|table|partitions|type |possible_keys|key|key_len|ref |rows|filtered|Extra                       |
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+----------------------------+
# |1 |SIMPLE     |t1   |null      |index|PRIMARY,a    |a  |5      |null|5   |100     |Using index; Using temporary|
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+----------------------------+
# 1,2,...,9,0
EXPLAIN
SELECT id%10 AS m, count(*) AS c FROM t1 GROUP BY m ORDER BY m;
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+--------------------------------------------+
# |id|select_type|table|partitions|type |possible_keys|key|key_len|ref |rows|filtered|Extra                                       |
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+--------------------------------------------+
# |1 |SIMPLE     |t1   |null      |index|PRIMARY,a    |a  |5      |null|5   |100     |Using index; Using temporary; Using filesort|
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+--------------------------------------------+
# 0,1,2,...,9
SET TMP_TABLE_SIZE = 128;
EXPLAIN
SELECT id%10 AS m, count(*) AS c FROM t1 GROUP BY m ORDER BY NULL LIMIT 10;

ALTER TABLE t1 ADD COLUMN z INT GENERATED ALWAYS AS (id % 100), ADD INDEX (z);

EXPLAIN
SELECT z, count(*) AS c FROM t1 GROUP BY z;
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+-----------+
# |id|select_type|table|partitions|type |possible_keys|key|key_len|ref |rows|filtered|Extra      |
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+-----------+
# |1 |SIMPLE     |t1   |null      |index|z            |z  |5      |null|1000|100     |Using index|
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+-----------+
# 0,1,2,...,99

EXPLAIN
SELECT SQL_BIG_RESULT id%100 AS m, count(*) AS c FROM t1 GROUP BY m;
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+---------------------------+
# |id|select_type|table|partitions|type |possible_keys|key|key_len|ref |rows|filtered|Extra                      |
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+---------------------------+
# |1 |SIMPLE     |t1   |null      |index|z            |z  |5      |null|1000|100     |Using index; Using filesort|
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+---------------------------+
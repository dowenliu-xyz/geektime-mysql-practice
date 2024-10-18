EXPLAIN SELECT a FROM t GROUP BY a ORDER BY NULL;
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+---------------+
# |id|select_type|table|partitions|type|possible_keys|key |key_len|ref |rows|filtered|Extra          |
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+---------------+
# |1 |SIMPLE     |t    |null      |ALL |null         |null|null   |null|5   |100     |Using temporary|
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+---------------+
EXPLAIN SELECT DISTINCT a FROM t;
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+---------------+
# |id|select_type|table|partitions|type|possible_keys|key |key_len|ref |rows|filtered|Extra          |
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+---------------+
# |1 |SIMPLE     |t    |null      |ALL |null         |null|null   |null|5   |100     |Using temporary|
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+---------------+

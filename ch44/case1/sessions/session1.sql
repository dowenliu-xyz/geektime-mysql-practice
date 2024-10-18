EXPLAIN
SELECT * FROM a LEFT JOIN b ON (a.f1 = b.f1) AND (a.f2 = b.f2); /*Q1*/
# +--+--+----+----+
# |f1|f2|f1  |f2  |
# +--+--+----+----+
# |1 |1 |null|null|
# |2 |2 |null|null|
# |3 |3 |3   |3   |
# |4 |4 |4   |4   |
# |5 |5 |5   |5   |
# |6 |6 |6   |6   |
# +--+--+----+----+
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+------------------------------------------+
# |id|select_type|table|partitions|type|possible_keys|key |key_len|ref |rows|filtered|Extra                                     |
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+------------------------------------------+
# |1 |SIMPLE     |a    |null      |ALL |null         |null|null   |null|6   |100     |null                                      |
# |1 |SIMPLE     |b    |null      |ALL |null         |null|null   |null|6   |100     |Using where; Using join buffer (hash join)|
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+------------------------------------------+
EXPLAIN
SELECT * FROM a LEFT JOIN b ON (a.f1 = b.f1) WHERE (a.f2 = b.f2);/*Q2*/
# +--+--+--+--+
# |f1|f2|f1|f2|
# +--+--+--+--+
# |3 |3 |3 |3 |
# |4 |4 |4 |4 |
# |5 |5 |5 |5 |
# |6 |6 |6 |6 |
# +--+--+--+--+
# +--+-----------+-----+----------+----+-------------+----+-------+---------+----+--------+-----------+
# |id|select_type|table|partitions|type|possible_keys|key |key_len|ref      |rows|filtered|Extra      |
# +--+-----------+-----+----------+----+-------------+----+-------+---------+----+--------+-----------+
# |1 |SIMPLE     |b    |null      |ALL |null         |null|null   |null     |6   |100     |Using where|
# |1 |SIMPLE     |a    |null      |ref |f1           |f1  |5      |test.b.f1|1   |16.67   |Using where|
# +--+-----------+-----+----------+----+-------------+----+-------+---------+----+--------+-----------+
# 这里 where 条件导致 LEFT JOIN 语义与 JOIN 语义一致。 WARN 信息中提供了 MySQL 改写后的 SQL 信息。
# 使用 left join 时，左边的表不一定是驱动表
# 如果需要 left join 的语义，就不能把被驱动表的字段放在 where 条件里面做等值判断或不等值判断，必须都写在 on 里面。
EXPLAIN
SELECT * FROM a JOIN b ON (a.f1 = b.f1) AND (a.f2 = b.f2); /*Q3*/
EXPLAIN
SELECT * FROM a JOIN b ON (a.f1 = b.f1) WHERE (a.f2 = b.f2);/*Q4*/
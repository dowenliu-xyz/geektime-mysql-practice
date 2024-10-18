ANALYZE TABLE t1, t2;
EXPLAIN
SELECT * FROM t1 STRAIGHT_JOIN t2 ON (t1.a = t2.a);
# +--+-----------+-----+----------+----+-------------+----+-------+---------+----+--------+-----------+
# |id|select_type|table|partitions|type|possible_keys|key |key_len|ref      |rows|filtered|Extra      |
# +--+-----------+-----+----------+----+-------------+----+-------+---------+----+--------+-----------+
# |1 |SIMPLE     |t1   |null      |ALL |a            |null|null   |null     |100 |100     |Using where|
# |1 |SIMPLE     |t2   |null      |ref |a            |a   |5      |test.t1.a|1   |100     |null       |
# +--+-----------+-----+----------+----+-------------+----+-------+---------+----+--------+-----------+
# Index Nested Loop Join, NLJ。
# 被驱动表走索引。N + N * 2 * log(M)，N 为驱动表的结果行数，M 为被驱动表的行数。
# 1. 使用 join 语句，性能比强行拆成多个单表执行 SQL 语句的性能要好；
# 2. 如果使用 join 语句的话，需要让小表做驱动表。
# 前提是“可以使用被驱动表的索引”

###

EXPLAIN
SELECT * FROM t1 STRAIGHT_JOIN t2 ON (t1.a = t2.b);
# 8.0.39: Using join buffer (hash join)
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+------------------------------------------+
# |id|select_type|table|partitions|type|possible_keys|key |key_len|ref |rows|filtered|Extra                                     |
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+------------------------------------------+
# |1 |SIMPLE     |t1   |null      |ALL |a            |null|null   |null|100 |100     |null                                      |
# |1 |SIMPLE     |t2   |null      |ALL |null         |null|null   |null|1000|10      |Using where; Using join buffer (hash join)|
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+------------------------------------------+
# 5.7.43: Using join buffer (Block Nested Loop)
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+--------------------------------------------------+
# |id|select_type|table|partitions|type|possible_keys|key |key_len|ref |rows|filtered|Extra                                             |
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+--------------------------------------------------+
# |1 |SIMPLE     |t1   |null      |ALL |a            |null|null   |null|100 |100     |null                                              |
# |1 |SIMPLE     |t2   |null      |ALL |null         |null|null   |null|1000|10      |Using where; Using join buffer (Block Nested Loop)|
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+--------------------------------------------------+
# Block Nested Loop Join, 相比 Simple Nested Loop Join ，扫描行数、对比次数相同，
# 但因为是提前把被驱动表的（全表或连续部分）数据加载到 join buffer，大部分扫描、对比都是内存中扫描，性能要好很多。
# join_buffer_size 越小，小表驱动大表的优势越明显。如果 join_buffer_size 足够大，大表或小表驱动都不影响。
# 尽管 MySQL (5.7) 已经使用 BNLJ 优化的 SNLJ ，但 BNLJ 的性能还是比较差，所以应该避免 BNLJ 的 join 或适当添加索引以转化成 BNL。
# 另外如果被驱动表是个大的冷表，还会导致 join buffer young part 可能被污染影响命中率。考虑加索引转化为 BNL 或 BKA

# 大表小表的判断依据是 结果大小 * 行大小 = 放到 join buffer 的数据大小。

###

SELECT @@join_buffer_size;
SET SESSION JOIN_BUFFER_SIZE = 1200;
EXPLAIN
SELECT * FROM t1 STRAIGHT_JOIN t2 ON (t1.a = t2.b);
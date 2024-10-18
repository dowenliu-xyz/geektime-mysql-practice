ANALYZE TABLE t1, t2;
EXPLAIN
SELECT * FROM t1 WHERE a >= 1 AND a <= 100;
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+---------------------+
# |id|select_type|table|partitions|type |possible_keys|key|key_len|ref |rows|filtered|Extra                |
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+---------------------+
# |1 |SIMPLE     |t1   |null      |range|a            |a  |5      |null|100 |100     |Using index condition|
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+---------------------+
# 执行结果按 a 递增 (按 ID 递减)
SET OPTIMIZER_SWITCH = DEFAULT;
SET OPTIMIZER_SWITCH = 'mrr_cost_based=off';
EXPLAIN
SELECT * FROM t1 WHERE a >= 1 AND a <= 100;
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+--------------------------------+
# |id|select_type|table|partitions|type |possible_keys|key|key_len|ref |rows|filtered|Extra                           |
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+--------------------------------+
# |1 |SIMPLE     |t1   |null      |range|a            |a  |5      |null|100 |100     |Using index condition; Using MRR|
# +--+-----------+-----+----------+-----+-------------+---+-------+----+----+--------+--------------------------------+
# 执行结果按 a 递减（按 ID 递增）
# 只有在能积累足够多的 id 时，启用 MRR 才有“顺序性”性能优势
SET OPTIMIZER_SWITCH = DEFAULT;
EXPLAIN
SELECT * FROM t1 STRAIGHT_JOIN test.t2 ON (t1.a = t2.a);
# BNL
# 结果 t2.id 递减
SET OPTIMIZER_SWITCH = 'mrr=on,mrr_cost_based=off,batched_key_access=on';
EXPLAIN
SELECT * FROM t1 STRAIGHT_JOIN test.t2 ON (t1.a = t2.a);
# +--+-----------+-----+----------+----+-------------+----+-------+---------+----+--------+--------------------------------------+
# |id|select_type|table|partitions|type|possible_keys|key |key_len|ref      |rows|filtered|Extra                                 |
# +--+-----------+-----+----------+----+-------------+----+-------+---------+----+--------+--------------------------------------+
# |1 |SIMPLE     |t1   |null      |ALL |a            |null|null   |null     |1000|100     |Using where                           |
# |1 |SIMPLE     |t2   |null      |ref |a            |a   |5      |test.t1.a|1   |100     |Using join buffer (Batched Key Access)|
# +--+-----------+-----+----------+----+-------------+----+-------+---------+----+--------+--------------------------------------+
# 结果 t2.id 递增
SET OPTIMIZER_SWITCH = DEFAULT;
EXPLAIN
SELECT * FROM t1 JOIN test.t2 ON (t1.b = t2.b) WHERE t2.b >= 1 AND t2.b <= 2000;

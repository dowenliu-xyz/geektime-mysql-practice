EXPLAIN
SELECT *
FROM T
WHERE k BETWEEN 3 AND 5;
# type: range
# extra: Using index condition
# 回表前使用索引下推，减少了回表次数

--

EXPLAIN
SELECT ID
FROM T
WHERE k BETWEEN 3 AND 5;
# type: range
# extra: Using where; Using index
# Using index 使用覆盖索引（而避免了回表）；
# Using where 与回表无关，只是表示（通过覆盖索引）(引擎层)查询到的数据在返回前（在 Server 层）使用 where 条件（重新）进行了过滤检查。

--

EXPLAIN
SELECT *
FROM tuser
WHERE name LIKE '张%'
  AND age = 10
  AND ismale = 1;
# type: range
# extra: Using index condition; Using where
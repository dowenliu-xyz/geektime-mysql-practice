EXPLAIN SELECT COUNT(*) FROM tradelog WHERE MONTH(t_modified) = 7;
# type: index
# key: t_modified
# Extra: Using where; Using index
EXPLAIN
SELECT COUNT(*)
FROM tradelog
WHERE (t_modified >= '2016-7-1' AND t_modified < '2016-8-1')
   OR (t_modified >= '2017-7-1' AND t_modified < '2017-8-1')
   OR (t_modified >= '2018-7-1' AND t_modified < '2018-8-1');
# 8.0， 空表还是。type: index 全索引扫描
EXPLAIN SELECT * FROM tradelog WHERE tradeid = 110717;
# type: ALL 隐式类型转换导致全表扫描
# 等同于：
SELECT * FROM tradelog WHERE CAST(tradeid AS SIGNED INT) = 110717;
EXPLAIN SELECT * FROM tradelog WHERE id = '83126';
--
EXPLAIN SELECT d.* FROM tradelog l, trade_detail d WHERE d.tradeid = l.tradeid AND l.id = 2;
# 1,SIMPLE,l,,const,"PRIMARY,tradeid",PRIMARY,4,const,1,100,
# 1,SIMPLE,d,,ALL,tradeid,,,,1,100,Using where
# 等同于
EXPLAIN SELECT d.* FROM tradelog l, trade_detail d WHERE CONVERT(d.tradeid USING utf8mb4) = l.tradeid AND l.id = 2;
EXPLAIN SELECT l.operator FROM tradelog l, trade_detail d WHERE d.tradeid = l.tradeid AND d.id = 4;
# 1,SIMPLE,d,,const,"PRIMARY,tradeid",PRIMARY,4,const,1,100,
# 1,SIMPLE,l,,ref,tradeid,tradeid,131,const,1,100,Using index condition
# 等同于
EXPLAIN SELECT l.operator FROM tradelog l, trade_detail d WHERE CONVERT(d.tradeid USING utf8mb4) = l.tradeid AND d.id = 4;

ALTER TABLE trade_detail MODIFY tradeid VARCHAR(32) CHARACTER SET utf8mb4 DEFAULT NULL;
EXPLAIN SELECT d.* FROM tradelog l, trade_detail d WHERE d.tradeid = CONVERT(l.tradeid USING utf8) AND l.id = 2;
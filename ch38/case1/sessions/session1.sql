CREATE TABLE t1 (
    id INT PRIMARY KEY,
    c  INT
)
    ENGINE = Memory;
CREATE TABLE t2 (
    id INT PRIMARY KEY,
    c  INT
)
    ENGINE = InnoDB;
INSERT INTO t1
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5),
       (6, 6),
       (7, 7),
       (8, 8),
       (9, 9),
       (0, 0);
INSERT INTO t2
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5),
       (6, 6),
       (7, 7),
       (8, 8),
       (9, 9),
       (0, 0);
SELECT * FROM t1;
# 1,2,...,9,0
SELECT * FROM t2;
# 0,1,...,9

DELETE FROM t1 WHERE id = 5;
INSERT INTO t1 VALUES (10,10);
SELECT * FROM t1;
# 1,2,3,4,10,6,7,8,9,0

EXPLAIN SELECT * FROM t1 WHERE id < 5;
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+-----------+
# |id|select_type|table|partitions|type|possible_keys|key |key_len|ref |rows|filtered|Extra      |
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+-----------+
# |1 |SIMPLE     |t1   |null      |ALL |PRIMARY      |null|null   |null|10  |33.33   |Using where|
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+-----------+
#                                  ^
ALTER TABLE t1 ADD INDEX a_btree_index USING BTREE (id);
EXPLAIN SELECT * FROM t1 WHERE id < 5;
# +--+-----------+-----+----------+-----+---------------------+-------------+-------+----+----+--------+-----------+
# |id|select_type|table|partitions|type |possible_keys        |key          |key_len|ref |rows|filtered|Extra      |
# +--+-----------+-----+----------+-----+---------------------+-------------+-------+----+----+--------+-----------+
# |1 |SIMPLE     |t1   |null      |range|PRIMARY,a_btree_index|a_btree_index|4      |null|6   |100     |Using where|
# +--+-----------+-----+----------+-----+---------------------+-------------+-------+----+----+--------+-----------+
# 0,1,2,3,4
EXPLAIN SELECT * FROM t1 FORCE INDEX (`PRIMARY`) WHERE id < 5;
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+-----------+
# |id|select_type|table|partitions|type|possible_keys|key |key_len|ref |rows|filtered|Extra      |
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+-----------+
# |1 |SIMPLE     |t1   |null      |ALL |PRIMARY      |null|null   |null|10  |33.33   |Using where|
# +--+-----------+-----+----------+----+-------------+----+-------+----+----+--------+-----------+
# 1,2,3,4,0
--
UPDATE t1 SET id = sleep(50) WHERE id = 1;
# User sleep, switch to session 2
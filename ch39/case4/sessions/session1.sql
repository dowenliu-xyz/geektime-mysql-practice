INSERT INTO t VALUES(NULL,1,1);
INSERT INTO t VALUES (NULL, 2, 2);
INSERT INTO t VALUES (NULL, 3, 3);
INSERT INTO t VALUES (NULL, 4, 4);
CREATE TABLE t2 LIKE t;
INSERT INTO t2(c, d) SELECT c, d FROM t;
INSERT INTO t2 VALUES (NULL, 5, 5);
SELECT * FROM t2;
# +--+-+-+
# |id|c|d|
# +--+-+-+
# |1 |1|1|
# |2 |2|2|
# |3 |3|3|
# |4 |4|4|
# |8 |5|5|
# +--+-+-+

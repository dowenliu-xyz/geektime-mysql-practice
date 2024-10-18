INSERT INTO t VALUES(NULL,1,1);
BEGIN ;
INSERT INTO t VALUES (NULL, 2, 2);
ROLLBACK ;
INSERT INTO t VALUES (NULL, 2, 2);
SELECT * FROM t;
# +--+-+-+
# |id|c|d|
# +--+-+-+
# |1 |1|1|
# |3 |2|2|
# +--+-+-+
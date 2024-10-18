INSERT INTO t VALUES (NULL, 1, 1);
# OK
INSERT INTO t VALUES (NULL, 1, 1);
# [23000][1062] Duplicate entry '1' for key 't.c'
INSERT INTO t VALUES (NULL, 2, 2);
# OK
SELECT * FROM t;
# +--+-+-+
# |id|c|d|
# +--+-+-+
# |1 |1|1|
# |3 |2|2|
# +--+-+-+
SHOW CREATE TABLE t;
# [42S02][1146] Table 'test.t' doesn't exist
# switch to session 1
INSERT INTO t VALUES (1);
# OK
SELECT * FROM t;
# OK
# switch to session 1
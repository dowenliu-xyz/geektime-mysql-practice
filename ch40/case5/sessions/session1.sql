BEGIN;
INSERT INTO t VALUES (null, 5, 5);
# switch to session 2
ROLLBACK ;
# this unblocks session 2 and session 3, one of them will get a deadlock error

INSERT INTO t VALUES (2, 1, 100) ON DUPLICATE KEY UPDATE d = 100;
SELECT * FROM t;